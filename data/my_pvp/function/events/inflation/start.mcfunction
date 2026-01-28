# インフレーションイベント開始

# キルポイントを20(倍)に変更
scoreboard players set #POINT_KILL temp 20

# 告知
title @a title [{"text":"【インフレーション】","color":"gold","bold":true}]
title @a subtitle [{"text":"キルポイント2倍！","color":"yellow"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"インフレーション発生！","color":"red","bold":true},{"text":" - キル時のポイントが2倍になります！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 1 1
