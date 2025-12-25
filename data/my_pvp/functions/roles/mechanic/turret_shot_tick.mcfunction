# 1. 前進 (速度調整: ^ ^ ^0.8 がスピード。数値を上げると速くなる)
tp @s ^ ^ ^0.8

# 2. パーティクル演出 (軌跡)
particle minecraft:crit ~ ~ ~ 0 0 0 0 1

# 3. 寿命設定 (ずっと飛び続けるのを防ぐ)
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 60.. run kill @s

# --- 4. 命中判定 ---
scoreboard players operation #TEMP player_id = @s player_id

# 4-A. 壁に当たったら消滅
execute unless block ~ ~ ~ air unless block ~ ~ ~ light unless block ~ ~ ~ water run kill @s

# 4-B. プレイヤーにヒット
# 半径0.5m以内にいる「持ち主以外のプレイヤー」を探す
tag @a remove shot_hit
execute as @a[distance=..1.5] unless score @s player_id = #TEMP player_id run tag @s add shot_hit

# ヒット時の処理
# ダメージを与える (ダメージ元を特定するため、一度持ち主を探す)
tag @a remove owner_temp
execute as @a if score @s player_id = #TEMP player_id run tag @s add owner_temp

# 所有者がいればその人からのダメージ、いなければただの魔法ダメージ
execute if entity @a[tag=shot_hit] if entity @a[tag=owner_temp] as @a[tag=owner_temp,limit=1] run damage @p[tag=shot_hit] 4 minecraft:arrow by @s
execute if entity @a[tag=shot_hit] unless entity @a[tag=owner_temp] run damage @p[tag=shot_hit] 4 minecraft:arrow

# ヒットしたら矢を消す
execute if entity @a[tag=shot_hit] run kill @s