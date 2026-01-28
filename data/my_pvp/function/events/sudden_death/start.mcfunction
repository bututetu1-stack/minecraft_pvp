# サドンデスイベント開始
title @a title [{"text":"【サドンデス】","color":"dark_red","bold":true}]
title @a subtitle [{"text":"HP強制1！一撃が命取り...","color":"red"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"サドンデス","color":"dark_red","bold":true},{"text":" - 20秒間HP=1に固定！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.wither.ambient master @s ~ ~ ~ 0.5 0.5
