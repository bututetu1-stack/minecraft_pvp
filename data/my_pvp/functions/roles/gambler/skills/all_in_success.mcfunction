tellraw @s {"text":"[All-In] 成功！！ (周囲にダメージ)","color":"gold","bold":true}

execute at @s run tag @e[distance=..5,type=player,tag=!gambler] add all_in_target

execute if score #SPENT_COINS temp matches 40..59 as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true

execute if score #SPENT_COINS temp matches 60..79 as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true
execute if score #SPENT_COINS temp matches 60..79 as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 0 true

execute if score #SPENT_COINS temp matches 80..99 as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true
execute if score #SPENT_COINS temp matches 80..99 as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true

execute if score #SPENT_COINS temp matches 100.. as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true
execute if score #SPENT_COINS temp matches 100.. as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true
execute if score #SPENT_COINS temp matches 100.. as @e[tag=all_in_target] run effect give @s minecraft:instant_damage 1 1 true

tag @e remove all_in_target
