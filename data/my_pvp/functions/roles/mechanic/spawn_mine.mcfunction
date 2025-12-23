# スクラップを2消費
scoreboard players remove @s scrap 2

# 最初から Invisible:1b（透明）で召喚
summon armor_stand ~ ~ ~ {Tags:["gadget","mine"],Health:5f,Small:1b,Invisible:1b,Marker:1b,ArmorItems:[{},{},{},{id:"minecraft:iron_trapdoor",Count:1b}]}

# 設置したエンジニアのIDをコピー（キル判定用）
execute as @e[tag=mine,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 設置音（自分だけに聞こえると「置いた感」が出て良いです）
playsound minecraft:block.iron_trapdoor.close ambient @s ~ ~ ~ 0.5 1.5