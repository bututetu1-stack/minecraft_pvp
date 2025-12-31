# --- 1. 旋回処理 ---
tp @s ~ ~ ~ ~4 ~

# ファントム公転
execute at @s run tp @e[tag=plane_1] ^ ^15 ^10 facing ^-10 ^15 ^10
execute at @s run tp @e[tag=plane_2] ^10 ^18 ^-5 facing ^15 ^18 ^5
execute at @s run tp @e[tag=plane_3] ^-10 ^18 ^-5 facing ^-5 ^18 ^-15

# --- 2. 共通処理 & 範囲警告 ---
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 0 0.5 0 0.1 5 force

# 警告リング
# A. 加賀
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle minecraft:dust 0 0 1 2 ^ ^ ^30 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle minecraft:dust 0 0 1 2 ^ ^ ^-30 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle minecraft:dust 0 0 1 2 ^30 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle minecraft:dust 0 0 1 2 ^-30 ^ ^ 0 0 0 0 1 force
# B. 瑞鶴
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle minecraft:dust 0 1 0 2 ^ ^ ^25 0 0 0 0 1 force
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle minecraft:dust 0 1 0 2 ^ ^ ^-25 0 0 0 0 1 force
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle minecraft:dust 0 1 0 2 ^25 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle minecraft:dust 0 1 0 2 ^-25 ^ ^ 0 0 0 0 1 force
# C. 瑞鳳
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle minecraft:dust 1 0 0 2 ^ ^ ^20 0 0 0 0 1 force
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle minecraft:dust 1 0 0 2 ^ ^ ^-20 0 0 0 0 1 force
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle minecraft:dust 1 0 0 2 ^20 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle minecraft:dust 1 0 0 2 ^-20 ^ ^ 0 0 0 0 1 force

# タイマー処理
scoreboard players remove @s timer 1
execute if score @s timer matches 1.. run return 0

# 攻撃主特定
scoreboard players operation #OWNER_ID temp = @s player_id

# --- 3. 爆弾投下 ---
# 3-1. 爆弾召喚 (Duration 100tick = 5秒)
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb","new_bomb"],Duration:100}

# 3-2. ID継承
execute as @e[tag=new_bomb] run scoreboard players operation @s player_id = #OWNER_ID temp

# 3-3. ガチャ (temp使用)
scoreboard players set #CONST_10 temp 10
execute as @e[tag=new_bomb] store result score @s temp run data get entity @s UUID[0]
execute as @e[tag=new_bomb] run scoreboard players operation @s temp %= #CONST_10 temp
execute as @e[tag=new_bomb] if score @s temp matches ..-1 run scoreboard players add @s temp 10
execute as @e[tag=new_bomb] run scoreboard players add @s temp 1

# 種類決定
execute as @e[tag=new_bomb] if score @s temp matches 1..6 run tag @s add type_suisei
execute as @e[tag=new_bomb] if score @s temp matches 1..6 run data modify entity @s CustomName set value '{"text":"彗星一二型甲","color":"red","bold":true}'

execute as @e[tag=new_bomb] if score @s temp matches 7..9 run tag @s add type_reppu
execute as @e[tag=new_bomb] if score @s temp matches 7..9 run data modify entity @s CustomName set value '{"text":"烈風改","color":"green","bold":true}'

execute as @e[tag=new_bomb] if score @s temp matches 10 run tag @s add type_ryusei
execute as @e[tag=new_bomb] if score @s temp matches 10 run data modify entity @s CustomName set value '{"text":"流星改","color":"blue","bold":true}'

# 3-4. 拡散 (spreadplayers)
execute if entity @s[tag=type_kaga] run spreadplayers ~ ~ 0 30 false @e[tag=new_bomb]
execute if entity @s[tag=type_zuikaku] run spreadplayers ~ ~ 0 25 false @e[tag=new_bomb]
execute if entity @s[tag=type_zuiho] run spreadplayers ~ ~ 0 20 false @e[tag=new_bomb]

# 3-5. 起爆タイマー設定 (tempを再利用)
# 40tick = 2秒後に爆発
execute as @e[tag=new_bomb] run scoreboard players set @s temp 40
execute as @e[tag=new_bomb] run tag @s add bomb_falling

tag @e[tag=new_bomb] remove new_bomb

# --- 4. サイクル更新 ---
scoreboard players remove @s ammo 1
scoreboard players set @s timer 5

# 終了判定
execute unless score @s ammo matches 1.. run kill @e[tag=adm_plane]
execute unless score @s ammo matches 1.. run kill @s