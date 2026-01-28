# --- 0. 凍結チェック (Frozen Check - Absolute Priority) ---
execute if entity @s[tag=is_frozen] run return 0

# --- 1. 落下制御 (Falling Logic) ---
# 空中にいる場合は地面に落とす
# 通過可能か判定 (タグファイル不具合回避のため直書き)
tag @s remove can_pass
execute if block ~ ~-0.1 ~ minecraft:air run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:void_air run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:cave_air run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:short_grass run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:tall_grass run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:fern run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:large_fern run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:vine run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:tripwire run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:water run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:lava run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:light run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:light run tag @s add can_pass
execute if block ~ ~-0.1 ~ minecraft:structure_void run tag @s add can_pass
# バリアも通過させる (天井バリア対策)
execute if block ~ ~-0.1 ~ minecraft:barrier run tag @s add can_pass

execute if entity @s[tag=bomb_falling,tag=can_pass] run tp @s ~ ~-1 ~
execute if entity @s[tag=bomb_falling,tag=!can_pass] run tag @s remove bomb_falling

# 落下中はタイマーを維持して処理を中断 (非表示)
execute if entity @s[tag=bomb_falling] run scoreboard players set @s temp 40
execute if entity @s[tag=bomb_falling] run return 0


# --- 1. ビジュアル (Visuals) ---

# === A. 彗星 (半径5m, 赤) ===
execute if entity @s[tag=type_suisei] run particle dust{color:[1.0,0.0,0.0],scale:1.5} ^ ^0.2 ^5 0 0 0 0 1 force
execute if entity @s[tag=type_suisei] run particle dust{color:[1.0,0.0,0.0],scale:1.5} ^ ^0.2 ^-5 0 0 0 0 1 force
execute if entity @s[tag=type_suisei] run particle dust{color:[1.0,0.0,0.0],scale:1.5} ^5 ^0.2 ^ 0 0 0 0 1 force
execute if entity @s[tag=type_suisei] run particle dust{color:[1.0,0.0,0.0],scale:1.5} ^-5 ^0.2 ^ 0 0 0 0 1 force
# 中心点
execute if entity @s[tag=type_suisei] run particle falling_dust{block_state:"minecraft:red_concrete"} ~ ~5 ~ 0.1 2 0.1 0 1 force


# === B. 烈風 (半径8m, 緑) ===
execute if entity @s[tag=type_reppu] run particle dust{color:[0.0,1.0,0.0],scale:1.5} ^ ^0.2 ^8 0 0 0 0 1 force
execute if entity @s[tag=type_reppu] run particle dust{color:[0.0,1.0,0.0],scale:1.5} ^ ^0.2 ^-8 0 0 0 0 1 force
execute if entity @s[tag=type_reppu] run particle dust{color:[1.0,0.0,0.0],scale:1.0} ~ ~ ~ 0.2 0.2 0.2 1 2 normal
execute if entity @s[tag=type_reppu] run particle dust{color:[0.0,1.0,0.0],scale:1.5} ^-8 ^0.2 ^ 0 0 0 0 1 force
# 中心点
execute if entity @s[tag=type_reppu] run particle falling_dust{block_state:"minecraft:lime_concrete"} ~ ~5 ~ 0.1 2 0.1 0 1 force


# === C. 流星 (半径6m, 青) ===
# 範囲強化: 4m -> 6m
execute if entity @s[tag=type_ryusei] run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^ ^0.2 ^6 0 0 0 0 1 force
execute if entity @s[tag=type_ryusei] run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^ ^0.2 ^-6 0 0 0 0 1 force
execute if entity @s[tag=type_ryusei] run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^6 ^0.2 ^ 0 0 0 0 1 force
execute if entity @s[tag=type_ryusei] run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^-6 ^0.2 ^ 0 0 0 0 1 force
# 中心点
execute if entity @s[tag=type_ryusei] run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute if entity @s[tag=type_ryusei] run particle falling_dust{block_state:"minecraft:blue_concrete"} ~ ~5 ~ 0.1 2 0.1 0 2 force

# --- 2. 凍結チェック (Frozen Check) ---
execute if entity @s[tag=is_frozen] run return 0

# --- 3. ロジック (Logic) ---

# --- 回転 (Rotation) ---
# 自身を回転させて、前方/後方/右/左にパーティクルを出すことで円を描く
tp @s ~ ~ ~ ~25 ~

# --- 音 ---
execute if score @s temp matches 20 run playsound minecraft:entity.phantom.flap master @a[distance=..10] ~ ~ ~ 1 2
execute if score @s temp matches 10 run playsound minecraft:entity.firework_rocket.launch master @a[distance=..10] ~ ~ ~ 1 0.5

# --- カウントダウン & 起爆 ---
scoreboard players remove @s temp 1
execute if score @s temp matches ..0 run function my_pvp:roles/admiral/process_bomb_explode