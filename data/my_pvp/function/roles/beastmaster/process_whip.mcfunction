# 鞭: 投げ禁止 → 即時返却
data merge entity @s {PickupDelay:0s}

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=beastmaster] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# アイテム返却
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_whip:1b}}}]}] run item replace entity @s container.0 with minecraft:iron_sword[minecraft:custom_data={beast_whip:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:2.0,operation:"add_value",slot:"mainhand",id:"my_pvp:beast_whip_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"鞭","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"攻撃力: 3","color":"gray"}','{"text":"命中で敵に slowness 1秒","color":"yellow"}']] 1

tag @a remove item_recipient
kill @s
