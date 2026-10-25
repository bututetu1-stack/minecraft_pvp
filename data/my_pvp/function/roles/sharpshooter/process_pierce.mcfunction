# 強撃弾 ドロップ処理 (3弾消費, damage 14, 35m貫通)
# @s = item entity (red_dye)

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 発射可能判定 (ammo >= 3)
tag @a remove sharp_fired_now
execute as @a[tag=item_recipient,scores={sharp_ammo=3..}] run tag @s add sharp_fired_now

# 発射: 残弾消費 + アイテム再配布 + 発射処理
execute as @a[tag=sharp_fired_now] run scoreboard players remove @s sharp_ammo 3
execute as @a[tag=sharp_fired_now] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_pierce:1b}}}]}] run item replace entity @s container.1 with minecraft:red_dye[minecraft:custom_data={sharpshooter_pierce:1b},minecraft:custom_name='{"text":"強撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 強撃弾発射 (3弾)","color":"yellow"}','{"text":"射程無制限・貫通, ダメージ14, 防御無視","color":"gray"}']] 1
execute as @a[tag=sharp_fired_now] at @s run function my_pvp:roles/sharpshooter/use_pierce

# 弾不足: アイテム返却 + 表示
execute as @a[tag=item_recipient,tag=!sharp_fired_now] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_pierce:1b}}}]}] run item replace entity @s container.1 with minecraft:red_dye[minecraft:custom_data={sharpshooter_pierce:1b},minecraft:custom_name='{"text":"強撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 強撃弾発射 (3弾)","color":"yellow"}','{"text":"射程無制限・貫通, ダメージ14, 防御無視","color":"gray"}']] 1
execute as @a[tag=item_recipient,tag=!sharp_fired_now] run title @s actionbar {"text":"強撃弾: 弾不足 (3弾必要)","color":"red"}
execute as @a[tag=item_recipient,tag=!sharp_fired_now] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.7

# 後始末
tag @a remove item_recipient
tag @a remove sharp_fired_now
kill @s
