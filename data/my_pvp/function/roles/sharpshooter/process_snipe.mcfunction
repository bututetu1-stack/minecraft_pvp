# 狙撃弾: バーサーカーパターン
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# CT中: 即時返却
execute as @a[tag=item_recipient,scores={cd_sharp_snipe=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_snipe:1b}}}]}] run give @s minecraft:red_dye[minecraft:custom_data={sharpshooter_snipe:1b},minecraft:custom_name='{"text":"狙撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 視線方向に貫通弾","color":"yellow"}','{"text":"距離30m, ダメージ8","color":"gray"}','{"text":"CT: 14s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_sharp_snipe=1..}] run title @s actionbar {"text":"狙撃弾 Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_sharp_snipe=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# CTゼロ: 発動
execute as @a[tag=item_recipient,scores={cd_sharp_snipe=..0}] at @s run function my_pvp:roles/sharpshooter/use_snipe

tag @a remove item_recipient
kill @s
