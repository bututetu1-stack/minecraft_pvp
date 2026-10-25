# Calculate Sector for Player and Apply Effect
# @s = Player
# Context: at @center

# 1. Identify Center Rotation
tag @e[tag=gambler_roulette_center,distance=..0.1,limit=1] add my_center
execute store result score #CENTER_ROT temp run data get entity @e[tag=my_center,limit=1] Rotation[0]

# 2. Identify Player Angle relative to Center
# Summon temp marker at center
summon marker ~ ~ ~ {Tags:["temp_angle_marker"]}
# Face player (判定中のプレイヤー @s を向く。マーカー基準の @p だと中心に一番近い人を全員分使ってしまう)
tag @s add roulette_calc_target
execute as @e[tag=temp_angle_marker] at @s facing entity @a[tag=roulette_calc_target,limit=1] feet run tp @s ~ ~ ~ ~ ~
tag @s remove roulette_calc_target
# Get rotation
execute as @e[tag=temp_angle_marker] store result score #PLAYER_ANGLE temp run data get entity @s Rotation[0]
kill @e[tag=temp_angle_marker]
tag @e[tag=my_center] remove my_center

# 3. Calculate Relative Angle (Player - Center)
# Example: Center 0 (S). Player at 90 (W). Angle 90. Rel 90.
# Example: Center 90 (W). Player at 90 (W). Angle 90. Rel 0. -> Red (0). Correct.

scoreboard players operation #FINAL_ROT temp = #PLAYER_ANGLE temp
scoreboard players operation #FINAL_ROT temp -= #CENTER_ROT temp

# Normalize 0-360
scoreboard players set #CONST_360 temp 360
scoreboard players operation #FINAL_ROT temp %= #CONST_360 temp
execute if score #FINAL_ROT temp matches ..-1 run scoreboard players add #FINAL_ROT temp 360

# 4. Map to Sector
# Sector 0 (Red) covers -15 to +15.
# Formula: (Angle + 15) % 360 / 30

scoreboard players add #FINAL_ROT temp 15
scoreboard players operation #FINAL_ROT temp %= #CONST_360 temp
scoreboard players set #CONST_30 temp 30
scoreboard players operation #FINAL_ROT temp /= #CONST_30 temp

# 5. Apply Effect
function my_pvp:roles/gambler/skills/roulette_apply_effect
