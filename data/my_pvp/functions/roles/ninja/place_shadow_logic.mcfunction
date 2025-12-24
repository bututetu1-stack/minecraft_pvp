# CT設定
scoreboard players set @s cd_ninja_mark 60

# --- 1. 古い身代わりの削除 ---
execute if score @s slot_cycle matches 1 as @e[tag=shadow_slot_1] if score @s player_id = @p player_id run kill @s
execute if score @s slot_cycle matches 2 as @e[tag=shadow_slot_2] if score @s player_id = @p player_id run kill @s
execute if score @s slot_cycle matches 3 as @e[tag=shadow_slot_3] if score @s player_id = @p player_id run kill @s

# --- 2. 新しい身代わりの召喚 ---
# A. 見た目 (Armor Stand)
# 【修正】Tagsに "temp_new_shadow" を追加しました（生まれたて判定用）
execute if score @s slot_cycle matches 1 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_1","temp_new_shadow"],CustomName:'{"text":"Shadow [1]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,DisabledSlots:4144959}
execute if score @s slot_cycle matches 2 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_2","temp_new_shadow"],CustomName:'{"text":"Shadow [2]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,DisabledSlots:4144959}
execute if score @s slot_cycle matches 3 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_3","temp_new_shadow"],CustomName:'{"text":"Shadow [3]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,DisabledSlots:4144959}

# --- 向きの同期（追加機能） ---
# 今召喚した身代わり(@e[tag=temp_new_shadow])の向きを、実行者であるプレイヤー(@s)と同じにする
data modify entity @e[tag=temp_new_shadow,limit=1] Rotation set from entity @s Rotation

# 一時タグを削除
tag @e[tag=temp_new_shadow] remove temp_new_shadow


# B. 当たり判定 (Interaction)
# 殴って壊す判定はこちらが担当します
execute if score @s slot_cycle matches 1 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_1"],width:0.8f,height:2.0f,response:1b}
execute if score @s slot_cycle matches 2 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_2"],width:0.8f,height:2.0f,response:1b}
execute if score @s slot_cycle matches 3 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_3"],width:0.8f,height:2.0f,response:1b}

# --- 3. ID設定 ---
execute as @e[tag=ninja_shadow,limit=2,sort=nearest] run scoreboard players operation @s player_id = @p player_id

# 演出
playsound minecraft:block.sand.break ambient @a ~ ~ ~ 1 0.5
particle minecraft:squid_ink ~ ~1 ~ 0.2 0.5 0.2 0.1 20

# --- 4. サイクルを進める ---
scoreboard players add @s slot_cycle 1
execute if score @s slot_cycle matches 4.. run scoreboard players set @s slot_cycle 1

# 通知
title @s actionbar [{"text":"Next Slot: ","color":"gray"},{"score":{"name":"@s","objective":"slot_cycle"},"color":"yellow"}]