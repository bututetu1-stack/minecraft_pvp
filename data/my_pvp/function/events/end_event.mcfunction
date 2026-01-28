# イベント終了処理

# 夜戦の場合は時刻を戻す
execute if score #GLOBAL event_type matches 6 run time set day
# 夜戦エンティティの削除
execute if score #GLOBAL event_type matches 6 run kill @e[tag=night_bomb]
execute if score #GLOBAL event_type matches 6 run kill @e[tag=night_torpedo]
execute if score #GLOBAL event_type matches 6 run kill @e[tag=night_artillery]

# バウンティの場合はタグを削除
tag @a remove bounty_target

# ラッシュモードのタグを削除
tag @a remove rush_mode

# サドンデス終了: 最大HPを40に戻す
execute if score #GLOBAL event_type matches 4 run execute as @a run attribute @s minecraft:max_health base set 40
execute if score #GLOBAL event_type matches 4 run effect give @a minecraft:instant_health 1 200 true
execute if score #GLOBAL event_type matches 7 run function my_pvp:events/roulette/cleanup
execute if score #GLOBAL event_type matches 8 run scoreboard players set #POINT_KILL temp 10

# イベントタイプをリセット
scoreboard players set #GLOBAL event_type 0

# 終了告知
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"イベント終了！","color":"white"}]
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 0.5
