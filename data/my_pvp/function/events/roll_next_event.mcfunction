# イベント抽選 (重複なし版)
# - 既に使用済み (event_used_X = 1) のイベントは除外
# - 全部使い切ったら使用済みフラグをリセット (8イベント中4回しか発火しないので通常起きない)

# 1. ランダム値を生成 (1-8)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #EVENT_RNG temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
scoreboard players set #CONST_8 temp 8
scoreboard players operation #EVENT_RNG temp %= #CONST_8 temp
scoreboard players add #EVENT_RNG temp 1
kill @e[tag=random_seed]

# 2. リトライ数を増やす (無限ループ対策)
scoreboard players add #ROLL_RETRY temp 1

# 3. 既出かどうか確認
# 既出なら再抽選
execute if score #EVENT_RNG temp matches 1 if score #GLOBAL event_used_1 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 2 if score #GLOBAL event_used_2 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 3 if score #GLOBAL event_used_3 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 4 if score #GLOBAL event_used_4 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 5 if score #GLOBAL event_used_5 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 6 if score #GLOBAL event_used_6 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 7 if score #GLOBAL event_used_7 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event
execute if score #EVENT_RNG temp matches 8 if score #GLOBAL event_used_8 matches 1.. if score #ROLL_RETRY temp matches ..30 run function my_pvp:events/roll_next_event

# 4. 採用 (#NEXT_EVENT_TYPE に保存)
scoreboard players operation #NEXT_EVENT_TYPE temp = #EVENT_RNG temp

# 5. 使用済みフラグを立てる
execute if score #NEXT_EVENT_TYPE temp matches 1 run scoreboard players set #GLOBAL event_used_1 1
execute if score #NEXT_EVENT_TYPE temp matches 2 run scoreboard players set #GLOBAL event_used_2 1
execute if score #NEXT_EVENT_TYPE temp matches 3 run scoreboard players set #GLOBAL event_used_3 1
execute if score #NEXT_EVENT_TYPE temp matches 4 run scoreboard players set #GLOBAL event_used_4 1
execute if score #NEXT_EVENT_TYPE temp matches 5 run scoreboard players set #GLOBAL event_used_5 1
execute if score #NEXT_EVENT_TYPE temp matches 6 run scoreboard players set #GLOBAL event_used_6 1
execute if score #NEXT_EVENT_TYPE temp matches 7 run scoreboard players set #GLOBAL event_used_7 1
execute if score #NEXT_EVENT_TYPE temp matches 8 run scoreboard players set #GLOBAL event_used_8 1
