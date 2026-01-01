# --- 1. オーナー特定と追従 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove current_aa_owner
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add current_aa_owner

# 【修正】 エフェクトをオーナーの「足元」に追従させる (~1.5 を削除)
execute at @p[tag=current_aa_owner,limit=1] run tp @s ~ ~ ~

# --- 2. 艦種ごとの防御効果 ---

# === A. 秋月: 「鉄壁防空」 ===
# 緑のダスト（足元）
execute if entity @s[tag=type_akizuki] at @s run particle minecraft:dust 0.2 1.0 0.2 1.0 ~ ~0.1 ~ 0.6 0 0.6 1 5 normal
# 効果: 耐性 IV + 火炎耐性
execute if entity @s[tag=type_akizuki] run effect give @p[tag=current_aa_owner] minecraft:resistance 1 3 true
execute if entity @s[tag=type_akizuki] run effect give @p[tag=current_aa_owner] minecraft:fire_resistance 1 0 true

# === B. 摩耶: 「対空噴進弾」 ===
# 赤のダスト（足元）
execute if entity @s[tag=type_maya] at @s run particle minecraft:dust 1.0 0.0 0.0 1.0 ~ ~0.1 ~ 0.6 0 0.6 1 5 normal
# 効果: ウィザーII + 鈍足
execute if entity @s[tag=type_maya] at @s as @a[distance=..4,tag=!current_aa_owner,gamemode=!spectator] run effect give @s minecraft:wither 2 1 true
execute if entity @s[tag=type_maya] at @s as @a[distance=..4,tag=!current_aa_owner,gamemode=!spectator] run effect give @s minecraft:slowness 1 1 true

# === C. Johnston: 「高速回避」 ===
# 青のダスト（足元）
execute if entity @s[tag=type_johnston] at @s run particle minecraft:dust 0.0 0.5 1.0 1.0 ~ ~0.1 ~ 0.6 0 0.6 1 5 normal
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

# --- 3. タイマー処理 ---
scoreboard players remove @s timer 1
execute if score @s timer matches ..0 run kill @s