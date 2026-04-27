# マーキング弾 ドロップ処理 (2弾消費, 命中で 5秒 glowing+slowness II + ダメ3)
# @s = item entity (charcoal)

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 発射可能判定 (ammo >= 2)
tag @a remove sharp_fired_now
execute as @a[tag=item_recipient,scores={sharp_ammo=2..}] run tag @s add sharp_fired_now

# 発射: 残弾消費 + アイテム再配布 + 発射処理
execute as @a[tag=sharp_fired_now] run scoreboard players remove @s sharp_ammo 2
execute as @a[tag=sharp_fired_now] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_mark:1b}}}]}] run item replace entity @s container.3 with minecraft:charcoal[minecraft:custom_data={sharpshooter_mark:1b},minecraft:custom_name='{"text":"マーキング弾","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): マーキング弾発射 (2弾)","color":"yellow"}','{"text":"距離25m貫通, 命中で5秒 発光+鈍足II + ダメ3","color":"gray"}']] 1
execute as @a[tag=sharp_fired_now] at @s run function my_pvp:roles/sharpshooter/use_mark

# 弾不足: アイテム返却 + 表示
execute as @a[tag=item_recipient,tag=!sharp_fired_now] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_mark:1b}}}]}] run item replace entity @s container.3 with minecraft:charcoal[minecraft:custom_data={sharpshooter_mark:1b},minecraft:custom_name='{"text":"マーキング弾","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): マーキング弾発射 (2弾)","color":"yellow"}','{"text":"距離25m貫通, 命中で5秒 発光+鈍足II + ダメ3","color":"gray"}']] 1
execute as @a[tag=item_recipient,tag=!sharp_fired_now] run title @s actionbar {"text":"マーキング弾: 弾不足 (2弾必要)","color":"red"}
execute as @a[tag=item_recipient,tag=!sharp_fired_now] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.7

# 後始末
tag @a remove item_recipient
tag @a remove sharp_fired_now
kill @s
