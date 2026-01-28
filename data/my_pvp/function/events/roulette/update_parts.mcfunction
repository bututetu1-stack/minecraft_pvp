# ルーレット部品の位置更新
# @s = Roulette Part (item_display)
# Context: Executed as Part

# 1. 角度計算 (CenterRot + Offset)
execute store result score #TARGET_ROT temp run data get entity @e[tag=roulette_center,limit=1,sort=nearest] Rotation[0]
scoreboard players operation #TARGET_ROT temp += @s sector_offset

# 2. 位置更新 (Macro TP)
# 中心(@e[tag=roulette_center]) の位置で、Calculated Rotation を向き、前方 part_radius に TP
# しかし @s は Part なので、Centerの場所を知る必要がある
# execute at @e[tag=roulette_center] rotated #TARGET_ROT 0 run tp @s ^ ^ ^$(radius) ?
# rotated コマンドは score を受け取れない。Macroが必要。

execute store result storage my_pvp:macro rotation float 1 run scoreboard players get #TARGET_ROT temp
execute store result storage my_pvp:macro radius double 1 run scoreboard players get @s part_radius

function my_pvp:events/roulette/apply_part_pos with storage my_pvp:macro
