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


# --- 3. ダメージ実行 (弾数増加に伴う調整版) ---

# === A. 彗星 (8ダメージ, 半径5m) ===
# 変更: 15 -> 8 (2発同時投下のため半減)
execute if entity @s[tag=type_suisei] as @a[distance=..5] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_suisei] as @a[distance=..5] run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_suisei] as @a[distance=..5] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 烈風 (6ダメージ, 半径8m) ===
# 変更: 12 -> 6 (広範囲へばら撒く用)
execute if entity @s[tag=type_reppu] as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_reppu] as @a[distance=..8] run damage @s 6 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_reppu] as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 流星 (15ダメージ, 半径6m) ===
# 変更: 30 -> 15 (即死ではなくなったが、重なれば死ぬ威力)
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_ryusei] as @a[distance=..6] run damage @s 15 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_ryusei] as @a[distance=..6] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# --- 4. 後始末 ---
kill @e[tag=dmg_proxy]
kill @s