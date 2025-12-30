# --- 1. 攻撃主の特定 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 埋まり防止 & 水平化 (これで地面の上に移動)
tp @s ~ ~1 ~ ~ 0

# --- 2. 演出 (共通) ---
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 5 0.5
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
particle minecraft:flash ~ ~ ~ 0 0 0 0 1 force

# --- 3. 演出 (マトリョーシカ方式 & 高さ補正) ---

# === A. 大和 (半径15m) ===
# 外周
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
# 外周
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
# 外周
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


# --- 4. ダメージ処理 ---
summon armor_stand ~ ~ ~ {Tags:["dmg_proxy"],Invisible:1b,Marker:1b,NoGravity:1b}

# 【キルログ用】 艦種に応じて名前を強制セット
execute if entity @s[tag=type_yamato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦大和","color":"dark_red","bold":true}'
execute if entity @s[tag=type_kongo] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦金剛","color":"gold","bold":true}'
execute if entity @s[tag=type_nagato] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set value '{"text":"戦艦長門","color":"light_purple","bold":true}'

# A. 【戦艦大和】 (半径15m)
execute if entity @s[tag=type_yamato] as @a[distance=..15] run damage @s 30 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest]

# B. 【戦艦金剛】 (半径8m)
execute if entity @s[tag=type_kongo] as @a[distance=..8] run damage @s 12 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest]

# C. 【戦艦長門】 (半径10m)
execute if entity @s[tag=type_nagato] as @a[distance=..10] run damage @s 20 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest]

# --- 5. 後始末 ---
kill @e[tag=dmg_proxy,distance=..2]
tag @a remove attacker_temp
kill @s