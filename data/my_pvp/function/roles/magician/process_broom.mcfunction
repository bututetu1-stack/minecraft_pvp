# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{components:{"minecraft:custom_data":{magician_broom:1b}}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者に返却
tp @s @p[tag=item_recipient]
kill @s
