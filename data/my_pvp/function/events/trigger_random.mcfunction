# ランダムイベント選択
# 既存イベントがあれば終了
execute if score #GLOBAL event_type matches 1.. run function my_pvp:events/end_event

scoreboard players set #GLOBAL event_timer 0

# ランダム値を生成 (1-7)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #EVENT_RNG temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
scoreboard players set #CONST_8 temp 8
scoreboard players operation #EVENT_RNG temp %= #CONST_8 temp
scoreboard players add #EVENT_RNG temp 1
kill @e[tag=random_seed]

# イベントタイプ設定
scoreboard players operation #GLOBAL event_type = #EVENT_RNG temp

# 継続時間設定 (20秒? = 800tick)
scoreboard players set #GLOBAL event_duration 800

# 各イベント開始処理
execute if score #GLOBAL event_type matches 1 run function my_pvp:events/fog/start
execute if score #GLOBAL event_type matches 2 run function my_pvp:events/low_gravity/start
execute if score #GLOBAL event_type matches 3 run function my_pvp:events/bounty/start
execute if score #GLOBAL event_type matches 4 run function my_pvp:events/sudden_death/start
execute if score #GLOBAL event_type matches 5 run function my_pvp:events/rush_mode/start
execute if score #GLOBAL event_type matches 6 run function my_pvp:events/night_battle/start
execute if score #GLOBAL event_type matches 7 run function my_pvp:events/roulette/start
execute if score #GLOBAL event_type matches 8 run function my_pvp:events/inflation/start
