# --- アクションバー ---
title @s actionbar [{"text":"Ammo: ","color":"gold"},{"score":{"name":"@s","objective":"sharp_ammo"},"color":"yellow"},{"text":"/10","color":"gray"}]

# --- 集中状態の検知 (slot0のスコープを右クリ保持中 = is_using_item) ---
tag @s remove sharp_focused
execute if entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{sharpshooter_focus:1b}}}},predicate=my_pvp:is_using_item] run tag @s add sharp_focused

# 集中中の効果
# 狙い安定: slowness II
execute if entity @s[tag=sharp_focused] run effect give @s minecraft:slowness 1 1 true
# 半径15内の敵に発光
scoreboard players operation #SHARP_ID temp = @s player_id
execute if entity @s[tag=sharp_focused] at @s as @a[gamemode=!spectator,distance=..15] unless score @s player_id = #SHARP_ID temp run effect give @s minecraft:glowing 1 0 true

# --- 残弾回復 ---
# 1) 時間経過: 4秒 (80tick) ごとに +1
scoreboard players add @s sharp_ammo_timer 1
execute if score @s sharp_ammo_timer matches 80.. if score @s sharp_ammo matches ..9 run scoreboard players add @s sharp_ammo 1
execute if score @s sharp_ammo_timer matches 80.. if score @s sharp_ammo matches ..9 run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.4 1.8
execute if score @s sharp_ammo_timer matches 80.. run scoreboard players set @s sharp_ammo_timer 0

# 2) キル時: +3
execute unless score @s last_kills = @s kills run scoreboard players add @s sharp_ammo 3
execute unless score @s last_kills = @s kills if score @s sharp_ammo matches 11.. run scoreboard players set @s sharp_ammo 10
execute unless score @s last_kills = @s kills run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.6 2.0
execute unless score @s last_kills = @s kills run tellraw @s [{"text":"[Kill] ","color":"gold"},{"text":"+3 Ammo","color":"yellow"}]
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# 上限ガード
execute if score @s sharp_ammo matches 11.. run scoreboard players set @s sharp_ammo 10

# --- 役職固有 上昇スキル (sneak短) ---
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/sharpshooter/use_jump

# --- アイテムスキャン ---
function my_pvp:roles/sharpshooter/scan_items
