# 1. 設置主（同じIDのエンジニア）を探し、その人によるダメージとして実行
execute as @a[tag=mechanic] if score @s player_id = @e[tag=mine,limit=1,sort=nearest,distance=..5] player_id run damage @p[distance=..3] 6 minecraft:explosion by @s

# 2. 演出（爆発エフェクトと音）
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 3. 使い終わった地雷を消去
kill @s