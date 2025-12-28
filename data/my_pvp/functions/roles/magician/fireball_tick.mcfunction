# 炎玉の毎tick処理

# 1. 寿命カウント
scoreboard players add @s gadget_life 1

# 2. 移動（視線方向に進む）
tp @s ^ ^ ^1

# 3. 視認性向上パーティクル（常時表示）
particle minecraft:flame ~ ~ ~ 0.15 0.15 0.15 0.02 3
particle minecraft:smoke ~ ~ ~ 0.1 0.1 0.1 0.01 1
# 軌跡パーティクル
particle minecraft:soul_fire_flame ~ ~ ~ 0.05 0.05 0.05 0.005 1

# 4. 敵に当たったかチェック（自分以外のプレイヤー）
tag @a remove mag_fb_target
execute as @a[distance=..1.5] unless score @s player_id = @e[type=small_fireball,tag=mag_fireball,limit=1,sort=nearest] player_id run tag @s add mag_fb_target

# 5. ヒット処理
execute if entity @a[tag=mag_fb_target,distance=..1.5] run function my_pvp:roles/magician/fireball_hit

# 6. ブロックに当たった場合 or 寿命切れ (3秒=60tick) で消滅
execute unless block ~ ~ ~ air unless block ~ ~ ~ cave_air run kill @s
execute if score @s gadget_life matches 60.. run kill @s
