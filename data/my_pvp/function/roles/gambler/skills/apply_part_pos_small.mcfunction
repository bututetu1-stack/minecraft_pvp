# Apply Position Logic (Small)
# @s = gambler_roulette_part
# Execution Context: AT the center entity

# 1. Rotate context to (CenterRot + Offset)
execute store result score #ROT temp run data get entity @e[tag=gambler_roulette_center,sort=nearest,limit=1] Rotation[0]
scoreboard players operation #ROT temp += @s sector_offset
execute store result entity @s Rotation[0] float 1 run scoreboard players get #ROT temp

# 2. Teleport to Center with Correct Rotation
# 2. Teleport to Center with Correct Rotation
# Use 3-arg TP to preserve the entity's rotation we just set
tp @s ~ ~0.5 ~

# 3. Move Local Z
# We need to run "tp @s ^ ^ ^RADIUS"
# Since radius is variable, we can use a macro or a recursive function.
# The Event uses fixed macro likely? No, let's assume simple brute force for 3/8 radius.

execute if score @s part_radius matches 3 at @s run tp @s ^ ^ ^2.5
execute if score @s part_radius matches 8 at @s run tp @s ^ ^ ^7.5
