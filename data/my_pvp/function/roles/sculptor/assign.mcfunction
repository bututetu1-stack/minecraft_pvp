tag @s add sculptor
scoreboard players set @s role_id 10
tag @s add role_assigned

tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『彫刻家』","color":"blue","bold":true},{"text":" です！","color":"white"}]

clear @s

scoreboard players set @s sculpture_cycle 1
scoreboard players set @s cd_sculptor_create 0
scoreboard players set @s sculpture_hp 0
attribute @s minecraft:max_health base set 40.0
effect clear @s
effect give @s minecraft:instant_health 1 255 true

execute at @s run playsound minecraft:block.anvil.place master @s ~ ~ ~ 1 1
