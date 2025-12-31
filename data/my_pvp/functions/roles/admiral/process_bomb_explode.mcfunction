# --- 1. 演出 ---
particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1

# --- 2. ダメージ処理準備 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# プロキシ召喚
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}
execute at @s run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set from entity @s CustomName


# --- 3. ダメージ実行 (火力強化版) ---

# === A. 彗星 (12ダメージ) ===
execute if entity @s[tag=type_suisei] as @a[distance=..5] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_suisei] as @a[distance=..5] run damage @s 12 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 烈風 (10ダメージ) ===
execute if entity @s[tag=type_reppu] as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_reppu] as @a[distance=..8] run damage @s 10 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 流星 (24ダメージ - 即死級) ===
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run damage @s 24 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# --- 4. 後始末 ---
kill @e[tag=dmg_proxy]
kill @s