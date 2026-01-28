# 濃霧イベント開始
title @a title [{"text":"【濃霧】","color":"dark_gray","bold":true}]
title @a subtitle [{"text":"視界が奪われる...","color":"gray"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"濃霧","color":"dark_gray","bold":true},{"text":" - 20秒間暗闇に包まれます！","color":"white"}]
execute as @a at @s run playsound minecraft:ambient.basalt_deltas.additions master @s ~ ~ ~ 1 0.5
