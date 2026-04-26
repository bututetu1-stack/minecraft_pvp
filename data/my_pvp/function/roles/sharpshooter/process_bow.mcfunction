# 弓: 投げ禁止 → 即時返却
data merge entity @s {PickupDelay:0s}

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# アイテム返却
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_bow:1b}}}]}] run item replace entity @s container.0 with minecraft:bow[minecraft:custom_data={sharpshooter_bow:1b},minecraft:enchantments={levels:{"minecraft:infinity":1}},minecraft:unbreakable={},minecraft:custom_name='{"text":"狙撃銃","color":"dark_gray","bold":true,"italic":false}',minecraft:lore=['{"text":"無限矢","color":"gray"}','{"text":"集中中はダメージ +50%","color":"yellow"}']] 1

tag @a remove item_recipient
kill @s
