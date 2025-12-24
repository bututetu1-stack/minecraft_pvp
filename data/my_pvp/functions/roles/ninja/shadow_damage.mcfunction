# 1. 攻撃データを消去（連打防止）
data remove entity @s interaction

# 2. 破壊演出（煙になって消える）
particle minecraft:poof ~ ~1 ~ 0.3 0.3 0.3 0.1 20
playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 1 1

# 3. 本体（見た目）を道連れにする
scoreboard players operation #TEMP player_id = @s player_id
execute at @s as @e[tag=shadow_visual,distance=..0.5,limit=1] if score @s player_id = #TEMP player_id run kill @s

# 4. 自分（当たり判定）を消す
kill @s