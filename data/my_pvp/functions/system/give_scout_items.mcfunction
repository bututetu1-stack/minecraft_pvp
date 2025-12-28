# 1. ワイヤーボウ
give @s minecraft:bow{display:{Name:'{"text":"ワイヤーボウ","color":"aqua","bold":true}',Lore:['{"text":"着弾地点まで高速移動","color":"gray"}','{"text":"Sneak: 移動キャンセル","color":"yellow"}','{"text":"CT: 5s","color":"aqua"}']},Unbreakable:1b,Enchantments:[{id:"minecraft:infinity",lvl:1s}],Tags:["scout_bow"]} 1

# 2. リパルサーブレード
# 【修正】Amount:3 -> 5 (合計攻撃力 4 -> 6)
give @s minecraft:iron_sword{scout_sword:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:1s}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:5,Operation:0,UUID:[I;111,222,333,444],Slot:"mainhand"}],display:{Name:'{"text":"リパルサーブレード","color":"white"}',Lore:['{"text":"攻撃力: 6 (固定)","color":"gray"}']},HideFlags:2} 1

# 3. 矢
give @s minecraft:arrow{scout_arrow:1b,display:{Name:'{"text":"矢 (無限)","color":"white"}'}} 1