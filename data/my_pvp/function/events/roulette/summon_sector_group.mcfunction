# Macro: Summon 10 parts for a sector to make a wedge shape (Range 0-50)
# Args: offset, item

# Part 1: Radius 2.5 (X 1.3, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[1.3f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 3
tag @e[tag=new_part] remove new_part

# Part 2: Radius 7.5 (X 3.9, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[3.9f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 8
tag @e[tag=new_part] remove new_part

# Part 3: Radius 12.5 (X 6.5, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[6.5f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 13
tag @e[tag=new_part] remove new_part

# Part 4: Radius 17.5 (X 9.1, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[9.1f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 18
tag @e[tag=new_part] remove new_part

# Part 5: Radius 22.5 (X 11.7, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[11.7f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 23
tag @e[tag=new_part] remove new_part

# Part 6: Radius 27.5 (X 14.3, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[14.3f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 28
tag @e[tag=new_part] remove new_part

# Part 7: Radius 32.5 (X 16.9, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[16.9f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 33
tag @e[tag=new_part] remove new_part

# Part 8: Radius 37.5 (X 19.5, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[19.5f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 38
tag @e[tag=new_part] remove new_part

# Part 9: Radius 42.5 (X 22.1, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[22.1f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 43
tag @e[tag=new_part] remove new_part

# Part 10: Radius 47.5 (X 24.7, Z 5)
$summon item_display ~ ~0.5 ~ {Tags:["roulette_part","new_part"],item_display:"fixed",transformation:{scale:[24.7f,0.1f,5.0f]},item:{id:"$(item)",count:1}}
$execute as @e[type=item_display,tag=new_part] run scoreboard players set @s sector_offset $(offset)
execute as @e[type=item_display,tag=new_part] run scoreboard players set @s part_radius 48
tag @e[tag=new_part] remove new_part