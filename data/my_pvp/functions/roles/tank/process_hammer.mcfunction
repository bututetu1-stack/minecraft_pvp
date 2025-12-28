# 1. 投げ禁止アイテムの即時回収設定
data merge entity @s {PickupDelay:0s}

# 2. アイテム配布
# 回収距離を15に設定。AttributeModifiersの数値を厳密に記述 (Amount:6 -> 6.0d)
execute as @p[tag=tank,distance=..15] run give @s minecraft:iron_shovel{tank_hammer:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:2s}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6.0d,Operation:0,UUID:[I;222,333,444,555],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.5d,Operation:0,UUID:[I;222,333,444,556],Slot:"mainhand"}],display:{Name:'{"text":"タイタンハンマー","color":"gold","bold":true}',Lore:['{"text":"重量級の一撃","color":"gray"}']},HideFlags:2} 1

# 3. 元のアイテムを消去
kill @s