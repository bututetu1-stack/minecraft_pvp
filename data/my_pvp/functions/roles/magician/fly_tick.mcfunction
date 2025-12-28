# 飛行中の毎tick処理（Levitation + Slow Falling ハイブリッド）
#
# 操作方法:
#   ジャンプキー押下: 上昇 (Levitation)
#   スニーク(Shift): 素早く下降 (エフェクト解除)
#   何もしない: ゆっくり下降 (Slow Falling)

# --- 1. スニーク中: 素早く下降 ---
# Levitationを解除し、Slow Fallingも一瞬解除して自然落下
execute if predicate my_pvp:is_sneaking run effect clear @s minecraft:levitation
execute if predicate my_pvp:is_sneaking run effect clear @s minecraft:slow_falling
# 下降中パーティクル
execute if predicate my_pvp:is_sneaking run particle minecraft:smoke ~ ~1 ~ 0.2 0.3 0.2 0.01 3

# --- 2. スニークしていない場合の処理 ---
# 地面にいない場合の上昇判定
# (ジャンプ検知は難しいため、地面にいなくてスニークしていなければ上昇)

# 地面にいるかチェック用タグ
tag @s remove on_ground
execute if block ~ ~-0.1 ~ #minecraft:mineable/shovel run tag @s add on_ground
execute if block ~ ~-0.1 ~ #minecraft:mineable/pickaxe run tag @s add on_ground
execute unless block ~ ~-0.5 ~ minecraft:air unless block ~ ~-0.5 ~ minecraft:cave_air unless block ~ ~-0.5 ~ minecraft:void_air run tag @s add on_ground

# --- 3. 空中での挙動 ---
# スニークしていない & 空中 = ゆっくり上昇 (Levitation 2で緩やかに上昇)
execute unless predicate my_pvp:is_sneaking unless entity @s[tag=on_ground] run effect give @s minecraft:levitation 1 1 true

# スニークしていない時は常にSlow Fallingを維持（急落下防止）
execute unless predicate my_pvp:is_sneaking run effect give @s minecraft:slow_falling 2 0 true

# --- 4. 地面に着いた場合 ---
# 地面検知で自動着陸はしない（手動で着陸するため）

# --- 5. 飛行中のエフェクト表示 ---
# 魔法陣パーティクル（5tickごと）
scoreboard players operation @s temp = #GLOBAL match_timer
scoreboard players operation @s temp %= #5 temp
execute if score @s temp matches 0 run particle minecraft:witch ~ ~0.5 ~ 0.3 0.1 0.3 0.02 5
execute if score @s temp matches 0 unless predicate my_pvp:is_sneaking unless entity @s[tag=on_ground] run particle minecraft:end_rod ~ ~ ~ 0.1 0.1 0.1 0.05 2

# --- 6. タグクリーンアップ ---
tag @s remove on_ground
