# 1. UI表示
title @s actionbar [{"text":"MANA: ","color":"light_purple"},{"score":{"name":"@s","objective":"mana"},"color":"white"}]

# 2. マナ自動回復 (1秒ごとに1増加) - ただし飛行中は回復しない
scoreboard players operation @s temp = #GLOBAL match_timer
scoreboard players operation @s temp %= #20 temp
execute if score @s temp matches 0 if score #GLOBAL match_timer matches 1.. unless entity @s[tag=mag_flying_true] run scoreboard players add @s mana 2

# マナ上限(100)
execute if score @s mana matches 101.. run scoreboard players set @s mana 100

# --- キル時のマナ回復 (+30) ---
execute unless score @s last_kills = @s kills run scoreboard players add @s mana 30
execute unless score @s last_kills = @s kills run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 2
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# 3. 飛行中のマナ消費 (タグ `mag_flying` がついている間、1秒ごとに5マナ消費)
#    シンプル化のため mag_fly_timer を使わず、20tickごとの判定は別途簡易化できます。
execute if entity @s[tag=mag_flying_true] run scoreboard players add @s mag_fly_tick 1
# 3a. 20tick到達時の処理: マナが5以上なら5消費、未満なら着陸させる（マイナス防止）
execute if entity @s[tag=mag_flying_true] unless entity @s[tag=rush_mode] if score @s mag_fly_tick matches 20.. if score @s mana matches 5.. run scoreboard players remove @s mana 5
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches 5.. run scoreboard players set @s mag_fly_tick 0
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches ..4 run function my_pvp:roles/magician/land
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches ..4 run scoreboard players set @s mag_fly_tick 0

# 3.5. 飛行中のエフェクト付与（シンプル化）
# タグ `mag_flying` がついている間だけ Levitation を付与する
execute as @s[tag=mag_flying_true] run effect give @s minecraft:levitation 2 4 true

# 4. マナ切れで強制着陸
execute if entity @s[tag=mag_flying_true] if score @s mana matches ..4 run function my_pvp:roles/magician/land

# 5. クールダウン消化 & アイテム返却

# 魔術箒 (Slot 0)
# 魔術箒 (Slot 0)
execute as @s[scores={cd_mag_broom=1}] run item replace entity @s container.0 with minecraft:stick[custom_name='{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',lore=['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}'],custom_data={magician_broom:1b}] 1
execute as @s[scores={cd_mag_broom=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_mag_broom=1..}] cd_mag_broom 1

# 魔術本 (Slot 1)
execute as @s[scores={cd_mag_book=1}] run item replace entity @s container.1 with minecraft:book[custom_name='{"text":"魔術本","italic":false,"color":"gold","bold":true}',lore=['{"text":"[Q]キー: 炎玉発射","color":"yellow"}','{"text":"Cost: 5 MANA","color":"gray"}','{"text":"ダメージ: ハート3個分","color":"red"}','{"text":"CT: 0s","color":"aqua"}'],custom_data={magician_book:1b}] 1
execute as @s[scores={cd_mag_book=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_mag_book=1..}] cd_mag_book 1

# 衝撃符 (Slot 2)
execute as @s[scores={cd_mag_shockwave=1}] run item replace entity @s container.2 with minecraft:white_dye[minecraft:custom_data={magician_shockwave:1b},minecraft:custom_name='{"text":"衝撃符","italic":false,"color":"aqua","bold":true}',minecraft:lore=['{"text":"[Q]キー: 自分中心 半径4m に衝撃波","color":"yellow"}','{"text":"Cost: 15 MANA","color":"gray"}','{"text":"damage 8 + 強ノックバック + 鈍足II 2秒","color":"red"}','{"text":"CT: 5s","color":"aqua"}']] 1
execute as @s[scores={cd_mag_shockwave=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 1.6
scoreboard players remove @s[scores={cd_mag_shockwave=1..}] cd_mag_shockwave 1

# 業火符 (Slot 3)
execute as @s[scores={cd_mag_inferno=1}] run item replace entity @s container.3 with minecraft:fire_charge[minecraft:custom_data={magician_inferno:1b},minecraft:custom_name='{"text":"業火符","italic":false,"color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー: 視線方向に魔法弾、着弾点半径5m爆発","color":"yellow"}','{"text":"Cost: 25 MANA","color":"gray"}','{"text":"damage 12 + 3秒燃焼","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1
execute as @s[scores={cd_mag_inferno=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 1.2
scoreboard players remove @s[scores={cd_mag_inferno=1..}] cd_mag_inferno 1

# Rush Mode Safety (CT0+不所持時の補充)
execute as @s[tag=rush_mode,scores={cd_mag_shockwave=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_shockwave:1b}}}]}] run item replace entity @s container.2 with minecraft:white_dye[minecraft:custom_data={magician_shockwave:1b},minecraft:custom_name='{"text":"衝撃符","italic":false,"color":"aqua","bold":true}',minecraft:lore=['{"text":"[Q]キー: 自分中心 半径4m に衝撃波","color":"yellow"}','{"text":"Cost: 15 MANA","color":"gray"}','{"text":"damage 8 + 強ノックバック + 鈍足II 2秒","color":"red"}','{"text":"CT: 5s","color":"aqua"}']] 1
execute as @s[tag=rush_mode,scores={cd_mag_inferno=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_inferno:1b}}}]}] run item replace entity @s container.3 with minecraft:fire_charge[minecraft:custom_data={magician_inferno:1b},minecraft:custom_name='{"text":"業火符","italic":false,"color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー: 視線方向に魔法弾、着弾点半径5m爆発","color":"yellow"}','{"text":"Cost: 25 MANA","color":"gray"}','{"text":"damage 12 + 3秒燃焼","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1

# --- 【新能力】 マナの恵み: マナ満タン時パッシブ強化 ---
execute if score @s mana matches 100.. run effect give @s minecraft:speed 1 0 true
execute if score @s mana matches 100.. run effect give @s minecraft:regeneration 1 0 true
