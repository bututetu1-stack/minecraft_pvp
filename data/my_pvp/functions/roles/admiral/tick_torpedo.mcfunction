# --- 移動処理 ---
tp @s ~ ~ ~ ~ 0
tp @s ^ ^ ^0.6

# 地面吸着
execute at @s if block ~ ~-0.1 ~ minecraft:air run tp @s ~ ~-0.5 ~
execute at @s unless block ~ ~ ~ minecraft:air run tp @s ~ ~0.5 ~

# --- 演出 (統一版) ---
# 艦種による分岐をなくし、泡のエフェクトのみにする
particle minecraft:bubble ~ ~ ~ 0 0 0 0.1 1 force
particle minecraft:splash ~ ~ ~ 0 0 0 0.1 1 force

# --- 衝突判定 ---
execute unless block ^ ^ ^0.7 minecraft:air run tag @s add hit_wall
execute as @a[distance=..1.5,tag=!admiral] run tag @e[tag=adm_torpedo,limit=1,sort=nearest] add hit_entity

# --- 爆発フラグ ---
execute if entity @s[tag=hit_wall] run tag @s add explode_now
execute if entity @s[tag=hit_entity] run tag @s add explode_now

# --- 爆発処理 ---
execute if entity @s[tag=explode_now] run function my_pvp:roles/admiral/process_torpedo_explode

# (安全装置)
scoreboard players add @s temp 1
execute if score @s temp matches 200.. run kill @s