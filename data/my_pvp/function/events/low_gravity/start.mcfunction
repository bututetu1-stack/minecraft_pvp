# 低重力イベント開始
title @a title [{"text":"【低重力】","color":"aqua","bold":true}]
title @a subtitle [{"text":"重力が弱まった！","color":"white"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"低重力","color":"aqua","bold":true},{"text":" - 20秒間跳躍力上昇&低速落下！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.flap master @s ~ ~ ~ 1 0.52
