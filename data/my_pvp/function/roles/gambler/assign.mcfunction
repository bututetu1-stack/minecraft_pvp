tag @s add gambler
tag @s add role_assigned
scoreboard players set @s role_id 11

tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『ギャンブラー』","color":"green","bold":true},{"text":" です！","color":"white"}]

clear @s

scoreboard players set @s coins 50
scoreboard players set @s coins_timer 0
scoreboard players enable @s bj_action
scoreboard players set @s bj_state 0
scoreboard players set @s bj_timer 0
scoreboard players set @s bj_hit_cd 0
scoreboard players set @s bj_debuff_timer 0
scoreboard players set @s fate_pot 0
scoreboard players set @s fate_streak 0
scoreboard players set @s fate_timer 0
scoreboard players set @s damage_boost 0
scoreboard players set @s skill_gambler_war 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0
attribute @s minecraft:max_health base set 40.0
effect clear @s
effect give @s minecraft:instant_health 1 255 true

execute at @s run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 1
