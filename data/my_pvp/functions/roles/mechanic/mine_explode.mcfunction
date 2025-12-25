scoreboard players operation #TEMP player_id = @s player_id
tag @a remove stepping_enemy

# 【復旧】踏んだ判定を @a に戻しました
execute as @a[distance=..2] unless score @s player_id = #TEMP player_id run tag @s add stepping_enemy

execute unless entity @a[tag=stepping_enemy] run return 0

particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 所有者特定
tag @a remove owner_temp
execute as @a if score @s player_id = #TEMP player_id run tag @s add owner_temp

# ダメージ処理 (execute as を使って単一対象問題を回避)
execute as @a[tag=stepping_enemy] run damage @s 8 minecraft:explosion by @p[tag=owner_temp]
execute as @a[distance=2.01..5] run damage @s 4 minecraft:explosion by @p[tag=owner_temp]

kill @s