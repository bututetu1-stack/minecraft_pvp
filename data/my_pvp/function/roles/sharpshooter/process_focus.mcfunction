# 集中スコープ ドロップ処理 (通常弾発射、1弾消費)
# @s = item entity (spyglass)

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 発射可能判定 (item_recipient かつ ammo >= 1)
tag @a remove sharp_fired_now
execute as @a[tag=item_recipient,scores={sharp_ammo=1..}] run tag @s add sharp_fired_now

# 発射: 残弾消費 + アイテム再配布 + 発射処理
execute as @a[tag=sharp_fired_now] run scoreboard players remove @s sharp_ammo 1
execute as @a[tag=sharp_fired_now] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_focus:1b}}}]}] run item replace entity @s container.0 with minecraft:spyglass[minecraft:custom_data={sharpshooter_focus:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"集中スコープ","color":"aqua","bold":true,"italic":false}',minecraft:lore=['{"text":"右クリ保持: 集中状態 (鈍足II + 半径15敵発光)","color":"yellow"}','{"text":"[Q]キー(捨てる): 通常弾発射 (1弾)","color":"yellow"}','{"text":"距離20m貫通, ダメージ6","color":"gray"}']] 1
execute as @a[tag=sharp_fired_now] at @s run function my_pvp:roles/sharpshooter/fire_normal_shot

# 弾切れ: アイテム返却 + 表示
execute as @a[tag=item_recipient,tag=!sharp_fired_now] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_focus:1b}}}]}] run item replace entity @s container.0 with minecraft:spyglass[minecraft:custom_data={sharpshooter_focus:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"集中スコープ","color":"aqua","bold":true,"italic":false}',minecraft:lore=['{"text":"右クリ保持: 集中状態 (鈍足II + 半径15敵発光)","color":"yellow"}','{"text":"[Q]キー(捨てる): 通常弾発射 (1弾)","color":"yellow"}','{"text":"距離20m貫通, ダメージ6","color":"gray"}']] 1
execute as @a[tag=item_recipient,tag=!sharp_fired_now] run title @s actionbar {"text":"弾切れ","color":"red"}
execute as @a[tag=item_recipient,tag=!sharp_fired_now] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.7

# 後始末
tag @a remove item_recipient
tag @a remove sharp_fired_now
kill @s
