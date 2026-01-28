execute as @a[tag=current_caster] unless score @s sculpture_cycle matches 1..20 run scoreboard players set @s sculpture_cycle 1

execute as @a[tag=current_caster] run scoreboard players operation #TEMP_SLOT temp = @s sculpture_cycle
execute as @a[tag=current_caster] run scoreboard players operation #TEMP_OWNER temp = @s player_id

execute as @e[tag=sculpture] if score @s player_id = #TEMP_OWNER temp if score @s sculpture_slot = #TEMP_SLOT temp run kill @s
execute as @e[tag=sculpture_hitbox] if score @s player_id = #TEMP_OWNER temp if score @s sculpture_slot = #TEMP_SLOT temp run kill @s

summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #SCULPT_THEME temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
scoreboard players set #CONST_8 temp 8
scoreboard players operation #SCULPT_THEME temp %= #CONST_8 temp
execute if score #SCULPT_THEME temp matches ..-1 run scoreboard players add #SCULPT_THEME temp 8
kill @e[tag=random_seed]

execute if score #SCULPT_THEME temp matches 0 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_nausea","new_sculpture"],CustomName:'{"text":"呪いの彫刻","color":"dark_purple","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}]}
execute if score #SCULPT_THEME temp matches 0 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"呪いの彫刻","color":"dark_purple"},{"text":" (見ると吐き気)","color":"white"}]

execute if score #SCULPT_THEME temp matches 1 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_poison","new_sculpture"],CustomName:'{"text":"毒の彫刻","color":"dark_green","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{id:"minecraft:leather_chestplate",count:1,components:{"minecraft:dyed_color":5635925}},{id:"minecraft:wither_skeleton_skull",count:1}],HandItems:[{id:"minecraft:poisonous_potato",count:1},{}]}
execute if score #SCULPT_THEME temp matches 1 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"毒の彫刻","color":"dark_green"},{"text":" (見ると毒)","color":"white"}]

execute if score #SCULPT_THEME temp matches 2 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_slow","new_sculpture"],CustomName:'{"text":"鈍足の彫刻","color":"gray","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{id:"minecraft:leather_boots",count:1,components:{"minecraft:dyed_color":5000268}},{id:"minecraft:leather_leggings",count:1,components:{"minecraft:dyed_color":5000268}},{id:"minecraft:leather_chestplate",count:1,components:{"minecraft:dyed_color":5000268}},{}],HandItems:[{id:"minecraft:cobweb",count:1},{}]}
execute if score #SCULPT_THEME temp matches 2 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"鈍足の彫刻","color":"gray"},{"text":" (見ると移動速度低下)","color":"white"}]

execute if score #SCULPT_THEME temp matches 3 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_blind","new_sculpture"],CustomName:'{"text":"盲目の彫刻","color":"black","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{},{id:"minecraft:player_head",count:1,components:{"minecraft:profile":{name:"MHF_Herobrine"}}}],HandItems:[{id:"minecraft:ender_eye",count:1},{}]}
execute if score #SCULPT_THEME temp matches 3 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"盲目の彫刻","color":"dark_gray"},{"text":" (見ると盲目)","color":"white"}]

execute if score #SCULPT_THEME temp matches 4 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_glow","new_sculpture"],CustomName:'{"text":"発光の彫刻","color":"yellow","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{id:"minecraft:golden_boots",count:1},{id:"minecraft:golden_leggings",count:1},{id:"minecraft:golden_chestplate",count:1},{id:"minecraft:golden_helmet",count:1}],HandItems:[{id:"minecraft:glowstone",count:1},{}]}
execute if score #SCULPT_THEME temp matches 4 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"発光の彫刻","color":"yellow"},{"text":" (見ると発光)","color":"white"}]

execute if score #SCULPT_THEME temp matches 5 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_darkness","new_sculpture"],CustomName:'{"text":"暗闇の彫刻","color":"dark_gray","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{id:"minecraft:netherite_boots",count:1},{id:"minecraft:netherite_leggings",count:1},{id:"minecraft:netherite_chestplate",count:1},{}],HandItems:[{id:"minecraft:sculk",count:1},{}]}
execute if score #SCULPT_THEME temp matches 5 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"暗闘の彫刻","color":"dark_gray"},{"text":" (見ると暗闇)","color":"white"}]

execute if score #SCULPT_THEME temp matches 6 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_fatigue","new_sculpture"],CustomName:'{"text":"鈍重の彫刻","color":"blue","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{id:"minecraft:iron_chestplate",count:1},{}],HandItems:[{id:"minecraft:anvil",count:1},{}]}
execute if score #SCULPT_THEME temp matches 6 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"鈍重の彫刻","color":"blue"},{"text":" (見ると攻撃速度低下)","color":"white"}]

execute if score #SCULPT_THEME temp matches 7 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_heal","new_sculpture"],CustomName:'{"text":"回復の彫刻","color":"green","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{id:"minecraft:leather_chestplate",count:1,components:{"minecraft:dyed_color":5635925}},{id:"minecraft:player_head",count:1}],HandItems:[{id:"minecraft:golden_apple",count:1},{}]}
execute if score #SCULPT_THEME temp matches 7 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"回復の彫刻","color":"green"},{"text":" (破壊でHP回復)","color":"white"}]

execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_sculpture,limit=1] player_id = @s player_id
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_sculpture,limit=1] sculpture_slot = @s sculpture_cycle

execute as @a[tag=current_caster] at @s run summon interaction ~ ~ ~ {Tags:["sculpture_hitbox","new_hitbox"],width:0.8f,height:2.0f,response:1b}
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_hitbox,limit=1] player_id = @s player_id
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_hitbox,limit=1] sculpture_slot = @e[tag=new_sculpture,limit=1] sculpture_slot

scoreboard players set @e[tag=new_hitbox] sculpture_hp 3

execute as @e[tag=new_sculpture] run data modify entity @s Rotation set from entity @p[tag=current_caster] Rotation

execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_nausea] run tag @s add sculpture_nausea
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_poison] run tag @s add sculpture_poison
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_slow] run tag @s add sculpture_slow
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_blind] run tag @s add sculpture_blind
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_glow] run tag @s add sculpture_glow
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_darkness] run tag @s add sculpture_darkness
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_fatigue] run tag @s add sculpture_fatigue
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_heal] run tag @s add sculpture_heal

tag @e[tag=new_sculpture] remove new_sculpture
tag @e[tag=new_hitbox] remove new_hitbox

scoreboard players set @a[tag=current_caster] sculpture_count 0
execute as @e[tag=sculpture] if score @s player_id = #TEMP_OWNER temp run scoreboard players add @a[tag=current_caster] sculpture_count 1

scoreboard players set @a[tag=current_caster] cd_sculptor_create 100

playsound minecraft:block.anvil.use master @a ~ ~ ~ 1 0.8
particle minecraft:cloud ~ ~1 ~ 0.3 0.5 0.3 0.02 10

execute as @a[tag=current_caster] run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"彫刻設置数: ","color":"white"},{"score":{"name":"@s","objective":"sculpture_count"},"color":"blue"},{"text":"/20","color":"gray"}]

execute as @a[tag=current_caster] if score @s sculpture_count matches 21.. run scoreboard players set @s sculpture_count 20

scoreboard players add @a[tag=current_caster] sculpture_cycle 1
execute as @a[tag=current_caster] if score @s sculpture_cycle matches 21.. run scoreboard players set @s sculpture_cycle 1
