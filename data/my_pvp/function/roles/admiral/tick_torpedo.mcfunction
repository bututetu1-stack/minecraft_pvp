# --- 1. 演出 (Visuals - Always Run) ---
# 艦種による分岐をなくし、泡のエフェクトのみにする
particle minecraft:bubble ~ ~ ~ 0 0 0 0.1 1 force
particle minecraft:splash ~ ~ ~ 0 0 0 0.1 1 force

# --- 2. 凍結チェック (Frozen Check) ---
execute if entity @s[tag=is_frozen] run return 0

# --- 3. ロジック (Logic) ---

# --- 移動処理 ---
tp @s ~ ~ ~ ~ 0
tp @s ^ ^ ^0.6

# 地面吸着
execute at @s if block ~ ~-0.1 ~ minecraft:air run tp @s ~ ~-0.5 ~
execute at @s unless block ~ ~ ~ minecraft:air run tp @s ~ ~0.5 ~

# --- 衝突判定 ---
# 壁判定 (タグファイル不使用・直書き)
tag @s remove is_safe_block
execute if block ^ ^ ^0.7 minecraft:air run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:void_air run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:cave_air run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:water run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:lava run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:short_grass run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:tall_grass run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:fern run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:large_fern run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:vine run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:tripwire run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:light run tag @s add is_safe_block
execute if block ^ ^ ^0.7 minecraft:structure_void run tag @s add is_safe_block

execute unless entity @s[tag=is_safe_block] run tag @s add hit_wall

# エンティティ判定 (自分以外のプレイヤーに当たったら爆発)
tag @s add processing_torp
execute as @a[distance=..1.5] unless score @s player_id = @e[tag=processing_torp,limit=1] player_id run tag @e[tag=processing_torp,limit=1] add hit_entity
tag @s remove processing_torp

# --- 爆発フラグ ---
execute if entity @s[tag=hit_wall] run tag @s add explode_now
execute if entity @s[tag=hit_entity] run tag @s add explode_now

# --- 爆発処理 ---
execute if entity @s[tag=explode_now] run function my_pvp:roles/admiral/process_torpedo_explode

# (安全装置)
scoreboard players add @s temp 1
execute if score @s temp matches 200.. run kill @s