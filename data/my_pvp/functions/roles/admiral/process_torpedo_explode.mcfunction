# --- 爆発処理 ---
execute unless entity @s[tag=explode_now] run return 0

# 攻撃主特定
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 共通演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 2 1
particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1

# ▼ ダメージ処理 ▼
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# 名前設定
execute if entity @s[tag=type_shimakaze] run data modify entity @e[tag=dmg_proxy,limit=1] CustomName set value '{"text":"61cm五連装(酸素)魚雷","color":"aqua","bold":true}'
execute if entity @s[tag=type_abukuma] run data modify entity @e[tag=dmg_proxy,limit=1] CustomName set value '{"text":"61cm四連装(酸素)魚雷","color":"gold","bold":true}'
execute if entity @s[tag=type_kitakami] run data modify entity @e[tag=dmg_proxy,limit=1] CustomName set value '{"text":"61cm五連装(酸素)魚雷","color":"green","bold":true}'

# ダメージ実行 & ポイント判定
# 【修正】 unless score @s player_id = #OWNER_ID temp を追加

# === A. 島風 (8ダメージ) ===
execute if entity @s[tag=type_shimakaze] as @a[distance=..4] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_shimakaze] as @a[distance=..4] unless score @s player_id = #OWNER_ID temp run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1] from @e[tag=dmg_proxy,limit=1]
execute if entity @s[tag=type_shimakaze] as @a[distance=..4] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 阿武隈 (12ダメージ) ===
execute if entity @s[tag=type_abukuma] as @a[distance=..4] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_abukuma] as @a[distance=..4] unless score @s player_id = #OWNER_ID temp run damage @s 12 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1] from @e[tag=dmg_proxy,limit=1]
execute if entity @s[tag=type_abukuma] as @a[distance=..4] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 北上 (10ダメージ) ===
execute if entity @s[tag=type_kitakami] as @a[distance=..4] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_kitakami] as @a[distance=..4] unless score @s player_id = #OWNER_ID temp run damage @s 10 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1] from @e[tag=dmg_proxy,limit=1]
execute if entity @s[tag=type_kitakami] as @a[distance=..4] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# 消滅
kill @e[tag=dmg_proxy]
tag @a remove attacker_temp
kill @s