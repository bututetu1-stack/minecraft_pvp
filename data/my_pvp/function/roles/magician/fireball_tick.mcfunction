# --- 1. 視認性パーティクル (Visuals - Always Run) ---
execute as @s at @s run particle minecraft:flame ~ ~ ~ 0.15 0.15 0.15 0.02 3
execute as @s at @s run particle minecraft:smoke ~ ~ ~ 0.1 0.1 0.1 0.01 1
execute as @s at @s run particle minecraft:soul_fire_flame ~ ~ ~ 0.05 0.05 0.05 0.005 1

# --- 2. 凍結チェック (Frozen Check) ---
# 【追加】凍結中は処理を停止 (パーティクル後)
execute if entity @s[tag=is_frozen] run return 0

# --- 3. ロジック (Logic) ---

# 寿命カウント（召喚時に score 初期化している前提）
scoreboard players add @s gadget_life 1

# 移動 — 回転を合わせた上でローカル座標で前方へ進める
# 弾速 2.5 blocks/tick = 50 m/s
execute as @s at @s run tp @s ^ ^ ^2.5

# 当たり判定 — 近接するエンティティに当たったらヒット処理へ
#    armor_stand 自身やマーカー系を除外する
execute as @s at @s if entity @e[distance=..3.0,limit=1,sort=nearest,type=!armor_stand,type=!marker] run function my_pvp:roles/magician/fireball_hit

# ブロック衝突 or 寿命切れで消滅
#    ブロックに埋まっている（非空気ブロックに接触）場合は消す
execute as @s at @s unless block ~ ~ ~ air unless block ~ ~ ~ cave_air run kill @s
execute as @s if score @s gadget_life matches 32.. run kill @s
