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

# === A. 彗星 (15ダメージ, 半径5m) ===
# 強化: 12 -> 15
execute if entity @s[tag=type_suisei] as @a[distance=..5] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_suisei] as @a[distance=..5] run damage @s 15 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 烈風 (12ダメージ, 半径8m) ===
# 強化: 10 -> 12
execute if entity @s[tag=type_reppu] as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_reppu] as @a[distance=..8] run damage @s 12 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 流星 (30ダメージ, 半径6m) ===
# 強化: 24 -> 30 (即死)
# 範囲強化: 4m -> 6m
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run damage @s 30 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# --- 4. 後始末 ---
kill @e[tag=dmg_proxy]
kill @s