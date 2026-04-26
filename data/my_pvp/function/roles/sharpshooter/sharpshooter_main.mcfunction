# --- アクションバー ---
title @s actionbar [{"text":"Snipe: ","color":"red"},{"score":{"name":"@s","objective":"cd_sharp_snipe"},"color":"white"},{"text":" | Smoke: ","color":"gray"},{"score":{"name":"@s","objective":"cd_sharp_smoke"},"color":"white"}]

# --- CT終了時のアイテム自動返却 (バーサーカーパターン) ---
# 狙撃弾 (slot 2)
execute as @s[scores={cd_sharp_snipe=1}] run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={sharpshooter_snipe:1b},minecraft:custom_name='{"text":"狙撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 視線方向に貫通弾","color":"yellow"}','{"text":"距離30m, ダメージ8","color":"gray"}','{"text":"CT: 14s","color":"aqua"}']] 1
execute as @s[scores={cd_sharp_snipe=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 0.7

# 煙幕弾 (slot 3)
execute as @s[scores={cd_sharp_smoke=1}] run item replace entity @s container.3 with minecraft:charcoal[minecraft:custom_data={sharpshooter_smoke:1b},minecraft:custom_name='{"text":"煙幕弾","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分に煙幕展開","color":"yellow"}','{"text":"自分: invisibility 4s","color":"gray"}','{"text":"周囲: blindness 3s","color":"gray"}','{"text":"CT: 22s","color":"aqua"}']] 1
execute as @s[scores={cd_sharp_smoke=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 1.5

# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_sharp_snipe=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_snipe:1b}}}]}] run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={sharpshooter_snipe:1b},minecraft:custom_name='{"text":"狙撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 視線方向に貫通弾","color":"yellow"}','{"text":"距離30m, ダメージ8","color":"gray"}','{"text":"CT: 14s","color":"aqua"}']] 1
execute as @s[tag=rush_mode,scores={cd_sharp_smoke=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_smoke:1b}}}]}] run item replace entity @s container.3 with minecraft:charcoal[minecraft:custom_data={sharpshooter_smoke:1b},minecraft:custom_name='{"text":"煙幕弾","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分に煙幕展開","color":"yellow"}','{"text":"自分: invisibility 4s","color":"gray"}','{"text":"周囲: blindness 3s","color":"gray"}','{"text":"CT: 22s","color":"aqua"}']] 1

# --- CT減少 ---
execute if score @s cd_sharp_snipe matches 1.. run scoreboard players remove @s cd_sharp_snipe 1
execute if score @s cd_sharp_smoke matches 1.. run scoreboard players remove @s cd_sharp_smoke 1

# --- 集中状態の検知 (slot0のスコープを右クリ保持中 = is_using_item) ---
tag @s remove sharp_focused
execute if entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{sharpshooter_focus:1b}}}},predicate=my_pvp:is_using_item] run tag @s add sharp_focused

# 集中中の効果
# 狙い安定: slowness II
execute if entity @s[tag=sharp_focused] run effect give @s minecraft:slowness 1 1 true
# 半径15内の敵に発光
scoreboard players operation #SHARP_ID temp = @s player_id
execute if entity @s[tag=sharp_focused] at @s as @a[gamemode=!spectator,distance=..15] unless score @s player_id = #SHARP_ID temp run effect give @s minecraft:glowing 1 0 true
# 集中演出パーティクル
execute if entity @s[tag=sharp_focused] at @s anchored eyes run particle minecraft:enchant ^ ^ ^2 0 0 0 0.5 3 force

# --- 自動連射 (集中中のみ、12tick = 0.6秒ごとに魔導弾発射) ---
# 集中中はタイマー加算
execute if entity @s[tag=sharp_focused] run scoreboard players add @s sharp_autofire_timer 1
# タイマー満了 → 発射
execute if entity @s[tag=sharp_focused] if score @s sharp_autofire_timer matches 12.. run function my_pvp:roles/sharpshooter/fire_magic_shot
execute if entity @s[tag=sharp_focused] if score @s sharp_autofire_timer matches 12.. run scoreboard players set @s sharp_autofire_timer 0
# 集中していないときはタイマーリセット
execute unless entity @s[tag=sharp_focused] run scoreboard players set @s sharp_autofire_timer 0

# --- 役職固有 上昇スキル (sneak短) ---
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/sharpshooter/use_jump

# --- アイテムスキャン ---
function my_pvp:roles/sharpshooter/scan_items
