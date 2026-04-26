# 煙幕弾: バーサーカーパターン
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# CT中: 即時返却
execute as @a[tag=item_recipient,scores={cd_sharp_smoke=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_smoke:1b}}}]}] run give @s minecraft:charcoal[minecraft:custom_data={sharpshooter_smoke:1b},minecraft:custom_name='{"text":"煙幕弾","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分に煙幕展開","color":"yellow"}','{"text":"自分: invisibility 4s","color":"gray"}','{"text":"周囲: blindness 3s","color":"gray"}','{"text":"CT: 22s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_sharp_smoke=1..}] run title @s actionbar {"text":"煙幕 Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_sharp_smoke=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# CTゼロ: 発動
execute as @a[tag=item_recipient,scores={cd_sharp_smoke=..0}] at @s run function my_pvp:roles/sharpshooter/use_smoke

tag @a remove item_recipient
kill @s
