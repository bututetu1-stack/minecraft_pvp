# --- 移動処理 ---
tp @s ~ ~ ~ ~ 0
tp @s ^ ^ ^0.5

# 地面吸着
execute at @s if block ~ ~-0.1 ~ minecraft:air run tp @s ~ ~-0.5 ~
execute at @s unless block ~ ~ ~ minecraft:air run tp @s ~ ~0.5 ~

# 演出
particle minecraft:bubble ~ ~ ~ 0 0 0 0.1 1 force
particle minecraft:splash ~ ~ ~ 0 0 0 0.1 1 force

# --- 衝突判定 ---
execute unless block ^ ^ ^0.6 minecraft:air run tag @s add hit_wall
execute as @a[distance=..1.5,tag=!admiral] run tag @e[tag=adm_torpedo,limit=1,sort=nearest] add hit_entity
execute if entity @s[tag=hit_wall] run tag @s add explode_now
execute if entity @s[tag=hit_entity] run tag @s add explode_now

# --- 爆発処理 (修正済) ---
# 爆発対象でなければスキップ
execute unless entity @s[tag=explode_now] run return 0

# 1. 攻撃主(飼い主)の特定
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 2. ダメージ実行 (範囲4ブロック)
# 飼い主がいる場合: by @p[tag=attacker_temp]
execute if entity @p[tag=attacker_temp] as @a[distance=..4] run damage @s 8 minecraft:player_explosion by @p[tag=attacker_temp,limit=1]
# 飼い主不在の場合
execute unless entity @p[tag=attacker_temp] as @a[distance=..4] run damage @s 8 minecraft:player_explosion

# 3. 演出と消滅
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 2 1
particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
tag @a remove attacker_temp
kill @s