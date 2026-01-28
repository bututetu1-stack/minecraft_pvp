tag @s add gambler
tag @s add role_assigned

tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『ギャンブラー』","color":"green","bold":true},{"text":" です！","color":"white"}]

clear @s

scoreboard players set @s coins 20
scoreboard players set @s coins_timer 0
scoreboard players enable @s bj_action
scoreboard players set @s bj_state 0
attribute @s minecraft:generic.max_health base set 40.0
effect clear @s
effect give @s minecraft:instant_health 1 255 true

execute at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 1
