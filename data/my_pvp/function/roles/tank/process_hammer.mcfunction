# 1. 投げ禁止アイテムの即時回収設定
data merge entity @s {PickupDelay:0s}

# 2. アイテム配布 (強化版)
# ・攻撃力: 6.0 -> 9.0 (基礎1.0+9.0 = 10ダメージ)
# ・攻撃速度: -3.5 -> -3.0 (少し速くしました)
# ・【追加】KnockbackResistance: 1.0 (攻撃を持ってる間はノックバック無効)
execute as @p[tag=tank,distance=..15] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_hammer:1b}}}]}] run give @s minecraft:iron_shovel[minecraft:custom_data={tank_hammer:1b},minecraft:unbreakable={},minecraft:enchantments={levels:{"minecraft:knockback":2}},minecraft:attribute_modifiers={modifiers:[{type:"generic.attack_damage",amount:9.0,operation:"add_value",slot:"mainhand",id:"my_pvp:tank_hammer_damage"},{type:"generic.attack_speed",amount:-2.5,operation:"add_value",slot:"mainhand",id:"my_pvp:tank_hammer_speed"},{type:"generic.knockback_resistance",amount:1.0,operation:"add_value",slot:"mainhand",id:"my_pvp:tank_hammer_kb_res"}],show_in_tooltip:false},minecraft:custom_name='{"text":"タイタンハンマー","color":"gold","bold":true}',minecraft:lore=['{"text":"不動の要塞","color":"gray"}']] 1

# 3. 元のアイテムを消去
kill @s