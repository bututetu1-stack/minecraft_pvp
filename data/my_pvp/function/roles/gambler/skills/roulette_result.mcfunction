# Result Logic (Spatial)
# @s = gambler_roulette_center

# 1. Iterate over players within radius 10
execute at @s as @a[distance=..10] at @e[tag=gambler_roulette_center,limit=1,sort=nearest] run function my_pvp:roles/gambler/skills/roulette_calc_sector

# 2. Cleanup
kill @e[tag=gambler_roulette_part,distance=..30]
kill @s
