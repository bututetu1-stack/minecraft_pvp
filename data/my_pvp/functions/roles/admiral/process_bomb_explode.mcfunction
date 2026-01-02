# --- 1. 演出 ---
particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1

# --- 2. ダメージ処理準備 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 【追加】 攻撃主の陣形を取得
scoreboard players set #FORMATION temp 0
execute as @a[tag=attacker_temp] run scoreboard players operation #FORMATION temp = @s adm_formation

# プロキシ召喚
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}
execute at @s run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set from entity @s CustomName


# --- 3. ダメージ実行 (弾数増加に伴う調整版) ---

# === A. 彗星 (基本8) ===
# 単縦:8, 輪形:5, 警戒:4
execute if entity @s[tag=type_suisei] as @a[distance=..5] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score #FORMATION temp matches 0 run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score #FORMATION temp matches 1 run damage @s 5 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score #FORMATION temp matches 2 run damage @s 4 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 烈風 (基本6) ===
# 単縦:6, 輪形:4, 警戒:3
execute if entity @s[tag=type_reppu] as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score #FORMATION temp matches 0 run damage @s 6 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score #FORMATION temp matches 1 run damage @s 4 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score #FORMATION temp matches 2 run damage @s 3 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 流星 (基本15) ===
# 単縦:15, 輪形:10, 警戒:7
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score #FORMATION temp matches 0 run damage @s 15 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score #FORMATION temp matches 1 run damage @s 10 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score #FORMATION temp matches 2 run damage @s 7 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# --- 4. 後始末 ---
kill @e[tag=dmg_proxy]
kill @s