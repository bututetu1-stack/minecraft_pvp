# スクラップを3消費
scoreboard players remove @s scrap 3

# 防具立てを召喚 (Invisible:1b, Marker:1b で判定を消しつつピストンを持たせる)
# Headにピストンを被せることで地面に埋まっているように見せます
summon armor_stand ~ ~-1 ~ {Tags:["gadget","launcher"],Health:6f,Invisible:1b,Marker:1b,ArmorItems:[{},{},{},{id:"minecraft:piston",Count:1b}]}

# 設置したエンジニアのIDをコピー
execute as @e[tag=launcher,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 設置音（重厚な金属音）
playsound minecraft:block.piston.extend ambient @a ~ ~ ~ 1 0.5