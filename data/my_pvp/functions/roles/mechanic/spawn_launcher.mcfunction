# スクラップを6消費
scoreboard players remove @s scrap 6

# CT設定
scoreboard players set @s cd_launcher 100
scoreboard players set @s gadget_life 20

# 召喚
summon armor_stand ~ ~-1 ~ {Tags:["gadget","launcher"],Invisible:1b,Marker:1b,ArmorItems:[{},{},{},{id:"minecraft:piston",Count:1b}]}

# ID設定
execute as @e[tag=launcher,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=current_caster] player_id

# 設置音
playsound minecraft:block.piston.extend ambient @a ~ ~ ~ 1 0.5