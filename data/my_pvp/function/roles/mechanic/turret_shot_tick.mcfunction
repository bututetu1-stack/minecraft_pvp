# 凍結中は処理をスキップ
execute if entity @s[tag=is_frozen] run return 0

# 1. 前進
tp @s ^ ^ ^0.8

# 2. 演出
particle minecraft:crit ~ ~ ~ 0 0 0 0 1
particle minecraft:electric_spark ~ ~ ~ 0 0 0 0 1

# 3. 寿命・衝突判定
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 60.. run kill @s
execute unless block ~ ~ ~ air unless block ~ ~ ~ light unless block ~ ~ ~ water run kill @s

# 4. ヒット判定
tag @a remove shot_hit
execute as @a[gamemode=!spectator] at @s positioned ~ ~1 ~ if entity @e[tag=turret_shot,distance=..1.5,limit=1] run tag @s add shot_hit

# 所有者への誤射防止
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=shot_hit] if score @s player_id = #TEMP player_id run tag @s remove shot_hit

execute unless entity @a[tag=shot_hit] run return 0

# 5. ダメージ処理 (修正版)
# 持ち主を特定
tag @a remove current_owner
execute as @a if score @s player_id = #TEMP player_id run tag @s add current_owner

# 【修正】攻撃者(current_owner)を指定してダメージ
execute as @a[tag=shot_hit,limit=1] run damage @s 2 minecraft:generic by @p[tag=current_owner,limit=1]

# 無敵時間リセット
execute as @a[tag=shot_hit,limit=1] run data merge entity @s {HurtTime:0s}

# 弾丸消去
kill @s