# --- 1. 攻撃主の特定 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 埋まり防止 & 水平化
tp @s ~ ~1 ~ ~ 0

# --- 2. 演出 (共通) ---
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 5 0.5
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
particle minecraft:flash ~ ~ ~ 0 0 0 0 1 force

# --- 3. 演出 (マトリョーシカ方式) ---

# === A. 大和 (半径15m) ===
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

# === B. 金剛 (半径8m) ===
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

# === C. 長門 (半径10m) ===
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


# --- 4. ダメージ処理 (Owner継承方式) ---

# 1. 代理攻撃用の雲(AEC)を召喚
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# 2. 攻撃主がいる場合、そのUUIDを雲のOwnerにコピーする
execute if entity @p[tag=attacker_temp] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] Owner set from entity @p[tag=attacker_temp,limit=1] UUID

# 3. 艦種に応じて雲に名前を付ける (フォールバック用)
execute if entity @s[tag=type_yamato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦大和","color":"dark_red","bold":true}'
execute if entity @s[tag=type_kongo] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦金剛","color":"gold","bold":true}'
execute if entity @s[tag=type_nagato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦長門","color":"light_purple","bold":true}'

# --- 4. ダメージ処理 (手動判定方式) ---

# 1. 代理攻撃用の雲(AEC)を召喚
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# 2. Ownerコピーは削除
# execute if entity @p[tag=attacker_temp] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] Owner set from entity @p[tag=attacker_temp,limit=1] UUID

# 3. 艦種に応じて雲に名前を付ける
execute if entity @s[tag=type_yamato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦大和","color":"dark_red","bold":true}'
execute if entity @s[tag=type_kongo] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦金剛","color":"gold","bold":true}'
execute if entity @s[tag=type_nagato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦長門","color":"light_purple","bold":true}'

# --- 4. ダメージ処理 (手動判定方式) ---

# 1. 代理攻撃用の雲(AEC)を召喚
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# 2. 艦種に応じて雲に名前を付ける
execute if entity @s[tag=type_yamato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦大和","color":"dark_red","bold":true}'
execute if entity @s[tag=type_kongo] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦金剛","color":"gold","bold":true}'
execute if entity @s[tag=type_nagato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦長門","color":"light_purple","bold":true}'

# 3. 攻撃実行 & ポイント判定
# 【修正】 unless score @s player_id = #OWNER_ID temp を追加して自分を除外

# === A. 大和 ===
execute if entity @s[tag=type_yamato] as @a[distance=..15] run scoreboard players operation @s temp = @s deaths
# ▼ ここを変更
execute if entity @s[tag=type_yamato] as @a[distance=..15] unless score @s player_id = #OWNER_ID temp run damage @s 30 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
# ▲
execute if entity @s[tag=type_yamato] as @a[distance=..15] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 金剛 ===
execute if entity @s[tag=type_kongo] as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
# ▼ ここを変更
execute if entity @s[tag=type_kongo] as @a[distance=..8] unless score @s player_id = #OWNER_ID temp run damage @s 12 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
# ▲
execute if entity @s[tag=type_kongo] as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 長門 ===
execute if entity @s[tag=type_nagato] as @a[distance=..10] run scoreboard players operation @s temp = @s deaths
# ▼ ここを変更
execute if entity @s[tag=type_nagato] as @a[distance=..10] unless score @s player_id = #OWNER_ID temp run damage @s 20 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
# ▲
execute if entity @s[tag=type_nagato] as @a[distance=..10] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1


# --- 5. 後始末 ---
kill @e[tag=dmg_proxy,distance=..2]
tag @a remove attacker_temp
kill @s