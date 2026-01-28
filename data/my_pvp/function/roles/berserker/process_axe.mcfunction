# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=berserker] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{berserker_axe:1b}}}]}] run give @s minecraft:iron_axe[minecraft:custom_data={berserker_axe:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:7.0,operation:"add_value",slot:"mainhand",id:"my_pvp:berserker_axe_damage"},{type:"attack_speed",amount:-3.0,operation:"add_value",slot:"mainhand",id:"my_pvp:berserker_axe_speed"}],show_in_tooltip:false},minecraft:custom_name='{"text":"ブラッドアックス","color":"red","bold":true}',minecraft:lore=['{"text":"攻撃力: 8 (重量級)","color":"gray"}']] 1

# 4. アイテム消去
kill @s