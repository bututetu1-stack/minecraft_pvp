# 【追加】凍結中は処理を停止
execute if entity @s[tag=is_frozen] run return 0

# 炎玉（armor_stand弾）の毎tick処理

# 1. 寿命カウント（召喚時に score 初期化している前提）
scoreboard players add @s gadget_life 1

# 2. 移動 — 回転を合わせた上でローカル座標で前方へ進める
# 速度を上げるため前進量を増加（0.6 -> 1.2）
execute as @s at @s run tp @s ^ ^ ^1.2

# 3. 視認性パーティクル（弾の位置で出す）
execute as @s at @s run particle minecraft:flame ~ ~ ~ 0.15 0.15 0.15 0.02 3
execute as @s at @s run particle minecraft:smoke ~ ~ ~ 0.1 0.1 0.1 0.01 1
execute as @s at @s run particle minecraft:soul_fire_flame ~ ~ ~ 0.05 0.05 0.05 0.005 1

# 4. 当たり判定 — 近接するエンティティに当たったらヒット処理へ
#    armor_stand 自身やマーカー系を除外する
execute as @s at @s if entity @e[distance=..1.5,limit=1,sort=nearest,type=!armor_stand,type=!marker] run function my_pvp:roles/magician/fireball_hit

# 5. ブロック衝突 or 寿命切れで消滅
#    ブロックに埋まっている（非空気ブロックに接触）場合は消す
execute as @s at @s unless block ~ ~ ~ air unless block ~ ~ ~ cave_air run kill @s
execute as @s if score @s gadget_life matches 60.. run kill @s
