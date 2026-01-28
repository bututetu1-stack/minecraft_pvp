# --- 1. オーナー特定 (Owner ID Calculation) ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove current_aa_owner
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add current_aa_owner

# --- 移動 (Movement - Follow) ---
# 凍結チェック: 凍結中は追従しない (その場に留まる)
# 【修正】 エフェクトをオーナーの「足元」に追従させる
execute unless entity @s[tag=is_frozen] at @p[tag=current_aa_owner,limit=1] run tp @s ~ ~ ~

# --- 2. ビジュアル (Visuals - Always Run) ---

# === A. 秋月 ===
# 緑のダスト（足元）
execute if entity @s[tag=type_akizuki] at @s run particle dust{color:[0.2,1.0,0.2],scale:1.0} ~ ~0.1 ~ 0.6 0 0.6 1 5 normal

# === B. 摩耶 ===
# 赤のダスト（足元）
execute if entity @s[tag=type_maya] at @s run particle dust{color:[1.0,0.0,0.0],scale:1.0} ~ ~0.1 ~ 0.6 0 0.6 1 5 normal

# === C. Johnston ===
# 青のダスト（足元）
execute if entity @s[tag=type_johnston] at @s run particle dust{color:[0.0,0.5,1.0],scale:1.0} ~ ~0.1 ~ 0.6 0 0.6 1 5 normal


# --- 3. 凍結チェック (Frozen Logic Check) ---
# これ以降のロジック（効果・タイマー）は凍結中スキップ
execute if entity @s[tag=is_frozen] run return 0


# --- 4. 効果 (Effects & Logic) ---

# === B. 摩耶 Effects ===
# 効果: ウィザーII + 鈍足
execute if entity @s[tag=type_maya] at @s as @a[distance=..4,tag=!current_aa_owner,gamemode=!spectator] run effect give @s minecraft:wither 2 1 true
execute if entity @s[tag=type_maya] at @s as @a[distance=..4,tag=!current_aa_owner,gamemode=!spectator] run effect give @s minecraft:slowness 1 1 true

# === C. Johnston Effects ===
# 効果: 移動速度上昇 II
execute if entity @s[tag=type_johnston] run effect give @p[tag=current_aa_owner] minecraft:speed 1 1 true

# 効果: 飛び道具・魔法消去
execute if entity @s[tag=type_johnston] at @s run kill @e[type=arrow,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=spectral_arrow,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=trident,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=snowball,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[tag=turret_shot,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[tag=mag_fireball,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=small_fireball,distance=..5]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=fireball,distance=..5]

# --- 5. タイマー処理 ---
scoreboard players remove @s timer 1
execute if score @s timer matches ..0 run kill @s