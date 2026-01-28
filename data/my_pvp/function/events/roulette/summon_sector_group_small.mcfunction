# Macro: Summon 2 parts for a sector to make a wedge shape (Radius ~10)
# Args: offset, item

# Part 1: Radius 2.5
$summon item_display ~ ~0.5 ~ {Tags:["gambler_roulette_part","new_part"],item_display:"fixed",transformation:{scale:[1.3f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 3
tag @e[tag=new_part] remove new_part

# Part 2: Radius 7.5
$summon item_display ~ ~0.5 ~ {Tags:["gambler_roulette_part","new_part"],item_display:"fixed",transformation:{scale:[3.9f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 8
tag @e[tag=new_part] remove new_part
