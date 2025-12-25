# --- 安全装置: slot_cycle が 0 以下なら 1 に強制設定 ---
execute unless score @s slot_cycle matches 1..3 run scoreboard players set @s slot_cycle 1

# --- 1. 古い身代わりの削除 ---
scoreboard players operation #TEMP player_id = @s player_id
execute if score @s slot_cycle matches 1 as @e[tag=shadow_slot_1] if score @s player_id = #TEMP player_id run kill @s
execute if score @s slot_cycle matches 2 as @e[tag=shadow_slot_2] if score @s player_id = #TEMP player_id run kill @s
execute if score @s slot_cycle matches 3 as @e[tag=shadow_slot_3] if score @s player_id = #TEMP player_id run kill @s

# --- 2. 新しい身代わりの召喚 ---
# A. 見た目 (Armor Stand)
# 【修正】NoBasePlate:1b を追加して台座を非表示に
execute if score @s slot_cycle matches 1 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_1","temp_new_shadow"],CustomName:'{"text":"Shadow [1]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,DisabledSlots:4144959}
execute if score @s slot_cycle matches 2 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_2","temp_new_shadow"],CustomName:'{"text":"Shadow [2]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,DisabledSlots:4144959}
execute if score @s slot_cycle matches 3 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_3","temp_new_shadow"],CustomName:'{"text":"Shadow [3]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,DisabledSlots:4144959}

# --- 向きの同期 ---
execute as @e[tag=temp_new_shadow,limit=1] run data modify entity @s Rotation set from entity @p[tag=current_user] Rotation
tag @e[tag=temp_new_shadow] remove temp_new_shadow

# B. 当たり判定 (Interaction)
execute if score @s slot_cycle matches 1 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_1"],width:0.8f,height:2.0f,response:1b}
execute if score @s slot_cycle matches 2 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_2"],width:0.8f,height:2.0f,response:1b}
execute if score @s slot_cycle matches 3 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_3"],width:0.8f,height:2.0f,response:1b}

# --- 3. ID設定 ---
execute as @e[tag=ninja_shadow,limit=2,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id

# 演出
playsound minecraft:block.sand.break ambient @a ~ ~ ~ 1 0.5
particle minecraft:squid_ink ~ ~1 ~ 0.2 0.5 0.2 0.1 20

# --- 4. サイクルを進める ---
scoreboard players add @s slot_cycle 1
execute if score @s slot_cycle matches 4.. run scoreboard players set @s slot_cycle 1

# 通知
title @s actionbar [{"text":"Next Slot: ","color":"gray"},{"score":{"name":"@s","objective":"slot_cycle"},"color":"yellow"}]