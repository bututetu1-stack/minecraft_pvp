# --- 1. 攻撃主の特定 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 埋まり防止 & 水平化
tp @s ~ ~1 ~ ~ 0

# 【追加】 攻撃主の陣形を取得して一時保存 (デフォルトは単縦陣=0)
scoreboard players set #FORMATION temp 0
execute as @a[tag=attacker_temp] run scoreboard players operation #FORMATION temp = @s adm_formation


# --- 2. 演出 (共通) ---
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 5 0.5
playsound minecraft:entity.warden.sonic_boom master @a ~ ~ ~ 3 0.7
playsound minecraft:entity.lightning_bolt.thunder master @a ~ ~ ~ 4 0.8
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
particle minecraft:explosion_emitter ~ ~3 ~ 0 0 0 1 1 force
particle minecraft:flash ~ ~ ~ 0 0 0 0 3 force
particle minecraft:flash ~ ~2 ~ 0 0 0 0 2 force
# 【追加】 衝撃波 sonic_boom (8方向に放射)
particle minecraft:sonic_boom ^ ^1 ^3 0 0 0 0 1 force
particle minecraft:sonic_boom ^ ^1 ^-3 0 0 0 0 1 force
particle minecraft:sonic_boom ^3 ^1 ^ 0 0 0 0 1 force
particle minecraft:sonic_boom ^-3 ^1 ^ 0 0 0 0 1 force

# --- 3. 演出 (マトリョーシカ方式) ---

# === A. 大和 (半径15m, 紅蓮の地獄) ===
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^15 0.5 1 0.5 0 20 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-15 0.5 1 0.5 0 20 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^15 ^ ^ 0.5 1 0.5 0 20 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^-15 ^ ^ 0.5 1 0.5 0 20 force
# 中周
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^10 0.5 1 0.5 0 15 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-10 0.5 1 0.5 0 15 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^10 ^ ^ 0.5 1 0.5 0 15 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^-10 ^ ^ 0.5 1 0.5 0 15 force
# 内周
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^5 0.5 1 0.5 0 10 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-5 0.5 1 0.5 0 10 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^5 ^ ^ 0.5 1 0.5 0 10 force
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:lava ^-5 ^ ^ 0.5 1 0.5 0 10 force
# 中心
execute if entity @s[tag=type_yamato] positioned ~ ~0.5 ~ run particle minecraft:cloud ~ ~1 ~ 4 1 4 0 100 force
# 【追加】 火柱 (中心から空に20mの火炎柱)
execute if entity @s[tag=type_yamato] positioned ~ ~ ~ run particle minecraft:flame ~ ~5 ~ 1 4 1 0.1 80 force
execute if entity @s[tag=type_yamato] positioned ~ ~ ~ run particle minecraft:lava ~ ~3 ~ 1 3 1 0 30 force
execute if entity @s[tag=type_yamato] positioned ~ ~ ~ run particle minecraft:dust{color:[1.0,0.2,0.0],scale:2.5} ~ ~6 ~ 2 4 2 0 60 force
# 衝撃波リング (赤いショックウェーブ)
execute if entity @s[tag=type_yamato] positioned ~ ~0.3 ~ run particle minecraft:dust{color:[1.0,0.4,0.0],scale:3.0} ~ ~ ~ 8 0.2 8 0 80 force
# 落下する瓦礫 (赤いコンクリート)
execute if entity @s[tag=type_yamato] positioned ~ ~ ~ run particle minecraft:falling_dust{block_state:"minecraft:red_concrete"} ~ ~10 ~ 8 2 8 0 30 force
execute if entity @s[tag=type_yamato] positioned ~ ~ ~ run particle minecraft:falling_lava ~ ~12 ~ 6 2 6 0 25 force
# 大和専用追加爆発音
execute if entity @s[tag=type_yamato] run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 6 0.3
execute if entity @s[tag=type_yamato] run playsound minecraft:item.firecharge.use master @a[distance=..50] ~ ~ ~ 4 0.5

# === B. 金剛 (半径8m, 雷光) ===
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^8 0.2 1 0.2 0 10 force
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-8 0.2 1 0.2 0 10 force
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^8 ^ ^ 0.2 1 0.2 0 10 force
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^-8 ^ ^ 0.2 1 0.2 0 10 force
# 中周
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^5 0.2 1 0.2 0 8 force
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-5 0.2 1 0.2 0 8 force
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^5 ^ ^ 0.2 1 0.2 0 8 force
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:lava ^-5 ^ ^ 0.2 1 0.2 0 8 force
# 中心
execute if entity @s[tag=type_kongo] positioned ~ ~0.5 ~ run particle minecraft:cloud ~ ~1 ~ 2 1 2 0 50 force
# 【追加】 電撃柱 (中心から空に金色の電撃)
execute if entity @s[tag=type_kongo] positioned ~ ~ ~ run particle minecraft:electric_spark ~ ~5 ~ 0.5 4 0.5 0.5 60 force
execute if entity @s[tag=type_kongo] positioned ~ ~ ~ run particle minecraft:end_rod ~ ~3 ~ 0.5 3 0.5 0.05 30 force
execute if entity @s[tag=type_kongo] positioned ~ ~ ~ run particle minecraft:dust{color:[1.0,0.95,0.2],scale:2.5} ~ ~6 ~ 1 4 1 0 50 force
# 衝撃波リング (金のショックウェーブ)
execute if entity @s[tag=type_kongo] positioned ~ ~0.3 ~ run particle minecraft:dust{color:[1.0,0.85,0.0],scale:3.0} ~ ~ ~ 5 0.2 5 0 50 force
# 火花の花火
execute if entity @s[tag=type_kongo] positioned ~ ~ ~ run particle minecraft:firework ~ ~3 ~ 3 2 3 0.3 30 force
# 金剛追加爆発音
execute if entity @s[tag=type_kongo] run playsound minecraft:item.firecharge.use master @a[distance=..40] ~ ~ ~ 3 1.0
execute if entity @s[tag=type_kongo] run playsound minecraft:entity.lightning_bolt.impact master @a[distance=..40] ~ ~ ~ 3 1.4

# === C. 長門 (半径10m, 闇の咆哮) ===
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^10 0.3 1 0.3 0 15 force
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-10 0.3 1 0.3 0 15 force
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^10 ^ ^ 0.3 1 0.3 0 15 force
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^-10 ^ ^ 0.3 1 0.3 0 15 force
# 中周
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^6 0.3 1 0.3 0 10 force
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^ ^ ^-6 0.3 1 0.3 0 10 force
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^6 ^ ^ 0.3 1 0.3 0 10 force
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:lava ^-6 ^ ^ 0.3 1 0.3 0 10 force
# 中心
execute if entity @s[tag=type_nagato] positioned ~ ~0.5 ~ run particle minecraft:cloud ~ ~1 ~ 3 1 3 0 80 force
# 【追加】 紫炎の柱 + ポータル渦
execute if entity @s[tag=type_nagato] positioned ~ ~ ~ run particle minecraft:soul_fire_flame ~ ~5 ~ 0.8 4 0.8 0.1 60 force
execute if entity @s[tag=type_nagato] positioned ~ ~ ~ run particle minecraft:portal ~ ~3 ~ 1 3 1 1 50 force
execute if entity @s[tag=type_nagato] positioned ~ ~ ~ run particle minecraft:dust{color:[0.5,0.0,1.0],scale:2.5} ~ ~6 ~ 1.5 4 1.5 0 50 force
# 衝撃波リング (紫のショックウェーブ)
execute if entity @s[tag=type_nagato] positioned ~ ~0.3 ~ run particle minecraft:dust{color:[0.6,0.1,1.0],scale:3.0} ~ ~ ~ 6 0.2 6 0 60 force
# 落下する闇の瓦礫
execute if entity @s[tag=type_nagato] positioned ~ ~ ~ run particle minecraft:falling_dust{block_state:"minecraft:purple_concrete"} ~ ~10 ~ 6 2 6 0 25 force
execute if entity @s[tag=type_nagato] positioned ~ ~ ~ run particle minecraft:large_smoke ~ ~5 ~ 3 3 3 0.05 40 force
# 長門追加爆発音
execute if entity @s[tag=type_nagato] run playsound minecraft:entity.warden.sonic_boom master @a ~ ~ ~ 4 0.5
execute if entity @s[tag=type_nagato] run playsound minecraft:entity.wither.shoot master @a[distance=..40] ~ ~ ~ 2 0.7


# --- 4. ダメージ処理 (手動判定方式) ---

# 1. 代理攻撃用の雲(AEC)を召喚
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# 2. 艦種に応じて雲に名前を付ける
execute if entity @s[tag=type_yamato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦大和","color":"dark_red","bold":true}'
execute if entity @s[tag=type_kongo] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦金剛","color":"gold","bold":true}'
execute if entity @s[tag=type_nagato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦長門","color":"light_purple","bold":true}'

# 3. 攻撃実行 & ポイント判定
# ※ unless score @s player_id = #OWNER_ID temp で自分へのダメージを除外

# === A. 大和 (基本30) ===
# 単縦(0):30, 輪形(1):20, 警戒(2):15
execute if entity @s[tag=type_yamato] as @a[distance=..15] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_yamato] as @a[distance=..15] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 0 run damage @s 30 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_yamato] as @a[distance=..15] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 1 run damage @s 20 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_yamato] as @a[distance=..15] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 2 run damage @s 15 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_yamato] as @a[distance=..15] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 金剛 (基本12) ===
# 単縦(0):12, 輪形(1):8, 警戒(2):6
execute if entity @s[tag=type_kongo] as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_kongo] as @a[distance=..8] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 0 run damage @s 12 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_kongo] as @a[distance=..8] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 1 run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_kongo] as @a[distance=..8] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 2 run damage @s 6 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_kongo] as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 長門 (基本20) ===
# 単縦(0):20, 輪形(1):13, 警戒(2):10
execute if entity @s[tag=type_nagato] as @a[distance=..10] run scoreboard players operation @s temp = @s deaths
execute if entity @s[tag=type_nagato] as @a[distance=..10] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 0 run damage @s 20 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_nagato] as @a[distance=..10] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 1 run damage @s 13 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_nagato] as @a[distance=..10] unless score @s player_id = #OWNER_ID temp if score #FORMATION temp matches 2 run damage @s 10 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute if entity @s[tag=type_nagato] as @a[distance=..10] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1


# --- 5. 後始末 ---
kill @e[tag=dmg_proxy,distance=..2]
tag @a remove attacker_temp
kill @s