# スクラップを8消費
execute unless entity @s[tag=rush_mode] run scoreboard players remove @s scrap 8

# CT設定 (3s = 60ticks)
execute unless entity @s[tag=rush_mode] run scoreboard players set @s cd_mine 60
execute if entity @s[tag=rush_mode] run scoreboard players set @s cd_mine 0
execute if entity @s[tag=rush_mode] run item replace entity @s container.1 with minecraft:iron_trapdoor[custom_name='{"text":"地雷","italic":false,"color":"gray"}',lore=['{"text":"Cost: 8 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:2b}] 1




# 本体召喚（透明）
summon armor_stand ~ ~ ~ {Tags:["gadget","mine"],Health:5f,Small:1b,Invisible:1b,Marker:1b,ArmorItems:[{},{},{},{}]}

# 設置したエンジニアのIDをコピー（キル判定用）
execute as @e[tag=mine,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 設置音
playsound minecraft:block.iron_trapdoor.close ambient @s ~ ~ ~ 0.5 1.5