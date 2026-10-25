# --- 1. 演出 (Visuals - Always Run) ---
particle minecraft:crit ~ ~ ~ 0 0 0 0 1
particle minecraft:electric_spark ~ ~ ~ 0 0 0 0 1

# --- 凍結チェック (Frozen Check) ---
# 凍結中は移動・判定・寿命処理を行わない
execute if entity @s[tag=is_frozen] run return 0

# --- 2. 前進 (Movement) ---
tp @s ^ ^ ^0.8

# --- 3. 寿命・衝突判定 ---
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 60.. run kill @s
execute unless block ~ ~ ~ air unless block ~ ~ ~ light unless block ~ ~ ~ water run kill @s

# --- 4. ヒット判定 ---
tag @a remove shot_hit
# この弾 (@s) の周囲だけを見る (以前は「どれか1発でも近くにある」で判定しており、全弾が命中扱いになっていた)
execute at @s positioned ~ ~-1 ~ as @a[gamemode=!spectator,distance=..1.5] run tag @s add shot_hit

# 所有者への誤射防止
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=shot_hit] if score @s player_id = #TEMP player_id run tag @s remove shot_hit

execute unless entity @a[tag=shot_hit] run return 0

# --- 5. ダメージ処理 ---
# 持ち主を特定
tag @a remove current_owner
execute as @a if score @s player_id = #TEMP player_id run tag @s add current_owner

# 無敵時間リセット
execute as @a[tag=shot_hit,limit=1] run data modify entity @s InvulnerableTime set value 0

# ダメージ付与
execute as @a[tag=shot_hit,limit=1] if entity @p[tag=current_owner] run damage @s 2 minecraft:generic by @p[tag=current_owner,limit=1]
execute as @a[tag=shot_hit,limit=1] unless entity @p[tag=current_owner] run damage @s 2 minecraft:generic

# 無敵時間リセット
execute as @a[tag=shot_hit,limit=1] run data merge entity @s {HurtTime:0s}

# 弾丸消去
kill @s