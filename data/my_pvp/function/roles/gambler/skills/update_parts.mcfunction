# Update small parts position relative to Gambler center
# @s = gambler_roulette_part

# Find Center - No need to calculate here, done in apply
# execute store result score #CENTER_ROT temp run data get entity @e[tag=gambler_roulette_center,sort=nearest,limit=1] Rotation[0]

# Calculate Angle - Done in apply
# scoreboard players operation #ANGLE temp = @s sector_offset
# ...

# Just execute the apply function at the center
execute at @e[tag=gambler_roulette_center,sort=nearest,limit=1] run function my_pvp:roles/gambler/skills/apply_part_pos_small
