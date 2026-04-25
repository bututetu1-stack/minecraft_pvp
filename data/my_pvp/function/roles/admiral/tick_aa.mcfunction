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


# --- 4. 対空対象判定 (aa_airborne タグ) ---
# 各tick、空中扱いのプレイヤーをタグ付け
tag @a remove aa_airborne

# ① OnGround:0b (ジャンプ・落下・打ち上げ中)
execute as @a[gamemode=!spectator] unless entity @s[nbt={OnGround:1b}] run tag @s add aa_airborne

# ② 飛行/突進タグ
execute as @a[tag=mag_flying_true] run tag @s add aa_airborne
execute as @a[tag=is_grappling] run tag @s add aa_airborne
execute as @a[tag=sam_iai_dashing] run tag @s add aa_airborne

# ③ Levitation 効果中
execute as @a[predicate=my_pvp:has_levitation] run tag @s add aa_airborne

# ④ 提督との高度差 +3 以上
execute store result score #ADM_Y temp run data get entity @s Pos[1] 1
execute as @a[gamemode=!spectator] store result score @s temp run data get entity @s Pos[1] 1
execute as @a[gamemode=!spectator] run scoreboard players operation @s temp -= #ADM_Y temp
execute as @a[gamemode=!spectator] if score @s temp matches 3.. run tag @s add aa_airborne


# --- 5. 効果 (Effects & Logic) ---

# === A. 秋月 (Akizuki) - 防御型 防空陣 ===
# 自己: 耐性 + 火炎耐性
execute if entity @s[tag=type_akizuki] run effect give @p[tag=current_aa_owner] minecraft:resistance 1 0 true
execute if entity @s[tag=type_akizuki] run effect give @p[tag=current_aa_owner] minecraft:fire_resistance 1 0 true
# 半径10内: 全飛び道具撃墜
execute if entity @s[tag=type_akizuki] at @s run kill @e[type=arrow,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[type=spectral_arrow,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[type=trident,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[type=snowball,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[tag=turret_shot,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[tag=mag_fireball,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[type=small_fireball,distance=..10]
execute if entity @s[tag=type_akizuki] at @s run kill @e[type=fireball,distance=..10]
# 半径10内の空中の敵: slow_falling 剥がし + 軽ダメージ
execute if entity @s[tag=type_akizuki] at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..10,gamemode=!spectator] run effect clear @s minecraft:slow_falling
execute if entity @s[tag=type_akizuki] if score @s timer matches 1.. run scoreboard players operation #AKIZUKI_TICK temp = @s timer
execute if entity @s[tag=type_akizuki] run scoreboard players operation #AKIZUKI_TICK temp %= #20 temp
execute if entity @s[tag=type_akizuki] if score #AKIZUKI_TICK temp matches 0 at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..10,gamemode=!spectator] run damage @s 2 minecraft:magic by @p[tag=current_aa_owner,limit=1]

# === B. 摩耶 (Maya) - 攻撃型 高角砲 ===
# 半径8内の空中の敵: 30tickごとにダメージ5 (5sで約2発)
execute if entity @s[tag=type_maya] run scoreboard players operation #MAYA_TICK temp = @s timer
execute if entity @s[tag=type_maya] run scoreboard players set #MAYA_MOD temp 30
execute if entity @s[tag=type_maya] run scoreboard players operation #MAYA_TICK temp %= #MAYA_MOD temp
execute if entity @s[tag=type_maya] if score #MAYA_TICK temp matches 0 at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..8,gamemode=!spectator] run damage @s 5 minecraft:magic by @p[tag=current_aa_owner,limit=1]
# 視覚演出: 命中対象位置に花火パーティクル
execute if entity @s[tag=type_maya] if score #MAYA_TICK temp matches 0 at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..8,gamemode=!spectator] at @s run particle minecraft:firework ~ ~1 ~ 0.3 0.3 0.3 0.3 20 force
execute if entity @s[tag=type_maya] if score #MAYA_TICK temp matches 0 at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..8,gamemode=!spectator] at @s run playsound minecraft:entity.firework_rocket.blast master @a ~ ~ ~ 1 1

# === C. Johnston - 撃墜型 急降下迎撃 ===
# 自己: 速度 + ジャンプ強化
execute if entity @s[tag=type_johnston] run effect give @p[tag=current_aa_owner] minecraft:speed 1 1 true
execute if entity @s[tag=type_johnston] run effect give @p[tag=current_aa_owner] minecraft:jump_boost 1 2 true
# 半径10内の空中の敵: levitation/slow_falling 剥がし + glowing + weakness
execute if entity @s[tag=type_johnston] at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..10,gamemode=!spectator] run effect clear @s minecraft:levitation
execute if entity @s[tag=type_johnston] at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..10,gamemode=!spectator] run effect clear @s minecraft:slow_falling
execute if entity @s[tag=type_johnston] at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..10,gamemode=!spectator] run effect give @s minecraft:glowing 8 0 true
execute if entity @s[tag=type_johnston] at @s as @a[tag=aa_airborne,tag=!current_aa_owner,distance=..10,gamemode=!spectator] run effect give @s minecraft:weakness 3 0 true
# 半径6内: 飛び道具撃墜
execute if entity @s[tag=type_johnston] at @s run kill @e[type=arrow,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=spectral_arrow,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=trident,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=snowball,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[tag=turret_shot,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[tag=mag_fireball,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=small_fireball,distance=..6]
execute if entity @s[tag=type_johnston] at @s run kill @e[type=fireball,distance=..6]


# --- 6. タイマー処理 ---
scoreboard players remove @s timer 1
execute if score @s timer matches ..0 run kill @s
