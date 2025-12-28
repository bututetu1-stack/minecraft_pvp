# スクラップを4消費 (5 -> 4)
scoreboard players remove @s scrap 4

# 本体召喚（透明）
summon armor_stand ~ ~ ~ {Tags:["gadget","mine"],Health:5f,Small:1b,Invisible:1b,Marker:1b,ArmorItems:[{},{},{},{}]}

# 設置したエンジニアのIDをコピー（キル判定用）
execute as @e[tag=mine,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 設置音
playsound minecraft:block.iron_trapdoor.close ambient @s ~ ~ ~ 0.5 1.5