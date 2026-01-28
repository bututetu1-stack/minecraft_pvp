# ラッシュモードイベント開始
title @a title [{"text":"【ラッシュモード】","color":"yellow","bold":true}]
title @a subtitle [{"text":"コスト消費なし！CT無限リセット！","color":"gold"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"ラッシュモード","color":"yellow","bold":true},{"text":" - 20秒間スキル使い放題！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.lightning_bolt.thunder master @s ~ ~ ~ 0.5 1.5

# ラッシュフラグを立てる
tag @a add rush_mode
