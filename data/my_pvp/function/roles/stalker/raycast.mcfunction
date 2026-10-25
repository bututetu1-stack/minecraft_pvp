# Stalker Gaze Raycast
# @s = Ray (Marker or Player context depending on implementation, here recursively called as Player)
# 再帰処理: 20m (0.5m * 40 steps)

# 1. 衝突判定 (ブロック)
execute unless block ~ ~ ~ #minecraft:air run return 0

# 2. ターゲット判定
# 半径1.5m以内にターゲットがいればヒット
execute as @a[tag=my_target,distance=..2] run effect give @s minecraft:glowing 1 0 true
execute as @a[tag=my_target,distance=..2] run effect give @s minecraft:slowness 1 2 true
# ヒットしたら #GAZE_HIT フラグを立てて終了 (狩りの時間用)
execute if entity @a[tag=my_target,distance=..2] run scoreboard players set #GAZE_HIT temp 1
execute if entity @a[tag=my_target,distance=..2] run return 1

# 3. 再帰 (距離制限)
scoreboard players remove #ray_dist temp 1
execute if score #ray_dist temp matches 1.. positioned ^ ^ ^0.5 run function my_pvp:roles/stalker/raycast
