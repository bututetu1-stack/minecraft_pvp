# 1. 設置主（同じIDのエンジニア）を探し、その人によるダメージとして実行
execute as @a[tag=mechanic] if score @s player_id = @e[tag=gadget,limit=1,sort=nearest,distance=..10] player_id run damage @p[distance=..7] 1 minecraft:magic by @s

# 2. 演出
particle minecraft:crit ~ ~1 ~ 0.2 0.2 0.2 0.1 5
playsound minecraft:entity.arrow.shoot ambient @a ~ ~ ~ 0.5 2