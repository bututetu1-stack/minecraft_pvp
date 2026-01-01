# 1. 投げ禁止アイテムの即時回収設定
data merge entity @s {PickupDelay:0s}

# 2. アイテム配布 (強化版)
# ・攻撃力: 6.0 -> 9.0 (基礎1.0+9.0 = 10ダメージ)
# ・攻撃速度: -3.5 -> -3.0 (少し速くしました)
# ・【追加】KnockbackResistance: 1.0 (攻撃を持ってる間はノックバック無効)
execute as @p[tag=tank,distance=..15] run give @s minecraft:iron_shovel{tank_hammer:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:2s}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:9.0d,Operation:0,UUID:[I;222,333,444,555],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-2.5d,Operation:0,UUID:[I;222,333,444,556],Slot:"mainhand"},{AttributeName:"generic.knockback_resistance",Name:"generic.knockback_resistance",Amount:1.0d,Operation:0,UUID:[I;222,333,444,557],Slot:"mainhand"}],display:{Name:'{"text":"タイタンハンマー","color":"gold","bold":true}',Lore:['{"text":"不動の要塞","color":"gray"}']},HideFlags:2} 1

# 3. 元のアイテムを消去
kill @s