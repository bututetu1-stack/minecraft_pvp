# 刀: 投げ禁止 → 即回収
data merge entity @s {PickupDelay:0s}

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=samurai] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 既に持っていない場合のみ返却
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{samurai_katana:1b}}}]}] run item replace entity @s container.0 with minecraft:iron_sword[minecraft:custom_data={samurai_katana:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:6.0,operation:"add_value",slot:"mainhand",id:"my_pvp:samurai_katana_damage"},{type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"my_pvp:samurai_katana_speed"}],show_in_tooltip:false},minecraft:custom_name='{"text":"刀","color":"red","bold":true}',minecraft:lore=['{"text":"攻撃力: 7","color":"gray"}','{"text":"一閃の太刀筋","color":"dark_red"}']] 1

# 元のアイテム消去
kill @s
