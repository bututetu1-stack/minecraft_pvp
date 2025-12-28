# 1. タイタンハンマー (鉄のシャベル)
# 攻撃力: 7 (ダイヤ剣相当), 攻撃速度: 遅い, ノックバックII
# 【修正】攻撃速度を -2.8 -> -3.5 に変更 (攻撃速度 0.5 = 2秒に1回)
give @s minecraft:iron_shovel{tank_hammer:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:2s}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;222,333,444,555],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.5,Operation:0,UUID:[I;222,333,444,556],Slot:"mainhand"}],display:{Name:'{"text":"タイタンハンマー","color":"gold","bold":true}',Lore:['{"text":"重量級の一撃","color":"gray"}']},HideFlags:2} 1

# 2. アースクラッシュ (スキル)
give @s minecraft:warped_fungus_on_a_stick{tank_skill:1b,display:{Name:'{"text":"アースクラッシュ","color":"green","bold":true}',Lore:['{"text":"右クリック: 周囲を吹き飛ばす","color":"gray"}','{"text":"CT: 10s","color":"aqua"}']},Unbreakable:1b} 1
