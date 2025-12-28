# --- 安全装置: slot_cycle が 0 以下なら 1 に強制設定 ---
execute unless score @s slot_cycle matches 1..3 run scoreboard players set @s slot_cycle 1

# --- 1. 古い身代わりの完全削除 ---
# テキストディスプレイにもタグとIDが付与されるようになったため、このコマンドで確実に消去されます
scoreboard players operation #TEMP player_id = @s player_id
execute if score @s slot_cycle matches 1 as @e[tag=shadow_slot_1] if score @s player_id = #TEMP player_id run kill @s
execute if score @s slot_cycle matches 2 as @e[tag=shadow_slot_2] if score @s player_id = #TEMP player_id run kill @s
execute if score @s slot_cycle matches 3 as @e[tag=shadow_slot_3] if score @s player_id = #TEMP player_id run kill @s

# --- 2. 新しい身代わりの召喚 ---
# 【修正】テキストディスプレイに "ninja_shadow", "shadow_slot_X" タグを追加
# これにより、試合終了時や置き換え時に検索・削除が可能になります

# Slot 1
execute if score @s slot_cycle matches 1 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_1","temp_new_shadow"],CustomName:'{"text":"Shadow [1]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,DisabledSlots:4144959,Passengers:[{id:"minecraft:text_display",Tags:["ninja_shadow","shadow_slot_1"],text:'{"text":"1","color":"yellow","bold":true}',billboard:"center",alignment:"center",transformation:{translation:[0.0f,2.2f,0.0f],scale:[2.0f,2.0f,2.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}]}

# Slot 2
execute if score @s slot_cycle matches 2 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_2","temp_new_shadow"],CustomName:'{"text":"Shadow [2]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,DisabledSlots:4144959,Passengers:[{id:"minecraft:text_display",Tags:["ninja_shadow","shadow_slot_2"],text:'{"text":"2","color":"yellow","bold":true}',billboard:"center",alignment:"center",transformation:{translation:[0.0f,2.2f,0.0f],scale:[2.0f,2.0f,2.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}]}

# Slot 3
execute if score @s slot_cycle matches 3 run summon armor_stand ~ ~ ~ {Tags:["ninja_shadow","shadow_visual","shadow_slot_3","temp_new_shadow"],CustomName:'{"text":"Shadow [3]","color":"yellow"}',ShowArms:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1908001}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],Invisible:0b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,DisabledSlots:4144959,Passengers:[{id:"minecraft:text_display",Tags:["ninja_shadow","shadow_slot_3"],text:'{"text":"3","color":"yellow","bold":true}',billboard:"center",alignment:"center",transformation:{translation:[0.0f,2.2f,0.0f],scale:[2.0f,2.0f,2.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}]}

# --- 向きの同期 ---
execute as @e[tag=temp_new_shadow,limit=1] run data modify entity @s Rotation set from entity @p[tag=current_caster] Rotation
tag @e[tag=temp_new_shadow] remove temp_new_shadow

# B. 当たり判定 (Interaction)
execute if score @s slot_cycle matches 1 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_1"],width:0.8f,height:2.0f,response:1b}
execute if score @s slot_cycle matches 2 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_2"],width:0.8f,height:2.0f,response:1b}
execute if score @s slot_cycle matches 3 run summon interaction ~ ~ ~ {Tags:["ninja_shadow","shadow_hitbox","shadow_slot_3"],width:0.8f,height:2.0f,response:1b}

# --- 3. ID設定 & 演出 ---
# 【修正】limit=2 -> 3 に変更
# 本体(AS), 判定(Interaction), 番号(TextDisplay) の3つ全てにIDを行き渡らせるため
execute as @e[tag=ninja_shadow,limit=3,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id

playsound minecraft:block.sand.break ambient @a ~ ~ ~ 1 0.5
particle minecraft:squid_ink ~ ~1 ~ 0.2 0.5 0.2 0.1 20

# --- 設置番号の通知 ---
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"身代わり[","color":"white"},{"score":{"name":"@s","objective":"slot_cycle"},"color":"yellow"},{"text":"] を設置しました","color":"white"}]

# --- 4. サイクルを進める ---
scoreboard players add @s slot_cycle 1
execute if score @s slot_cycle matches 4.. run scoreboard players set @s slot_cycle 1

# 次の準備 (アクションバー)
title @s actionbar [{"text":"Next Slot: ","color":"gray"},{"score":{"name":"@s","objective":"slot_cycle"},"color":"yellow"}]