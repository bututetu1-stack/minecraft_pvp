# 夜戦イベント開始
title @a title [{"text":"【夜戦】","color":"dark_blue","bold":true}]
title @a subtitle [{"text":"我、夜戦に突入す！","color":"gold","bold":true}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"夜戦","color":"dark_blue","bold":true},{"text":" - 20秒間夜になりランダム砲撃！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.firework_rocket.launch master @s ~ ~ ~ 1 0.5

# 夜にする
time set midnight
