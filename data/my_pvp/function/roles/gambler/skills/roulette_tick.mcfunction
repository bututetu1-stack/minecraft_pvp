# Gambler Roulette Tick
# @s = gambler_roulette_center

# 1. Check Timer
execute if score @s roulette_timer matches ..0 run function my_pvp:roles/gambler/skills/roulette_result
execute if score @s roulette_timer matches ..0 run return 0

# 2. Rotate
# Speed calculation: timer / 5?
scoreboard players operation #SPEED temp = @s roulette_timer
scoreboard players set #CONST_5 temp 5
scoreboard players operation #SPEED temp /= #CONST_5 temp
execute if score #SPEED temp matches ..0 run scoreboard players set #SPEED temp 1

# Apply Rotation
execute store result score #CUR_ROT temp run data get entity @s Rotation[0]
scoreboard players operation #CUR_ROT temp += #SPEED temp
execute store result entity @s Rotation[0] float 1 run scoreboard players get #CUR_ROT temp

# 3. Sound (Click)
# Logic: Sector = (360 - Rot + 15) % 360 / 30
# Used to determine the sector currently at South (0 degrees)

scoreboard players set #CONST_360 temp 360
scoreboard players operation #CUR_ROT temp %= #CONST_360 temp
# 1. 一時的に -1 を持つスコアを作る（定数として #MINUS_1 などを定義しておくと便利です）
scoreboard players set #MINUS_1 temp -1

# 2. そのスコアを使って掛け算する
scoreboard players operation #CUR_ROT temp *= #MINUS_1 temp
scoreboard players add #CUR_ROT temp 360
scoreboard players add #CUR_ROT temp 15
scoreboard players operation #CUR_ROT temp %= #CONST_360 temp

scoreboard players set #CONST_30 temp 30
scoreboard players operation #CUR_ROT temp /= #CONST_30 temp

# Detect Change
execute unless score #CUR_ROT temp = @s last_sector run playsound minecraft:ui.button.click master @a[distance=..20] ~ ~ ~ 0.5 2.0
execute unless score #CUR_ROT temp = @s last_sector run scoreboard players operation @s last_sector = #CUR_ROT temp

# 4. Update Parts
execute at @s run execute as @e[tag=gambler_roulette_part,distance=..20] run function my_pvp:roles/gambler/skills/update_parts

# 5. Decrement
scoreboard players remove @s roulette_timer 1
