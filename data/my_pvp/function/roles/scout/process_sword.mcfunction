# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# デバッグ：もし受け取り手が決まらなかったらログを出す
execute unless entity @a[tag=item_recipient] run tellraw @a [{"text":"[Debug] ","color":"red"},{"text":"所有者が見つかりません (ID不一致)","color":"white"}]

# 3. アイテム返却
# 【修正】Amount:3 -> 5 (合計攻撃力 4 -> 6)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{scout_sword:1b}}}]}] run give @s minecraft:iron_sword[minecraft:custom_data={scout_sword:1b},minecraft:unbreakable={},minecraft:enchantments={levels:{"minecraft:knockback":1}},minecraft:attribute_modifiers={modifiers:[{type:"generic.attack_damage",amount:5.0,operation:"add_value",slot:"mainhand",id:"my_pvp:scout_sword_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"リパルサーブレード","color":"white"}',minecraft:lore=['{"text":"攻撃力: 6 (固定)","color":"gray"}']] 1

# 4. アイテム消去
kill @s