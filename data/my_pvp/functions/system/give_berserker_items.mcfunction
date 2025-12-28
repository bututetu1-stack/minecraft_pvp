# --- バーサーカー装備 ---

# 1. ブラッドアックス
item replace entity @s container.0 with minecraft:iron_axe{berserker_axe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:7,Operation:0,UUID:[I;333,444,555,666],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.0,Operation:0,UUID:[I;333,444,555,667],Slot:"mainhand"}],display:{Name:'{"text":"ブラッドアックス","color":"red","bold":true}',Lore:['{"text":"攻撃力: 8 (重量級)","color":"gray"}']},HideFlags:2} 1

# 2. リープフェザー (更新)
item replace entity @s container.1 with minecraft:feather{berserker_jump:1b,display:{Name:'{"text":"リープフェザー","color":"green","bold":true}',Lore:['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"空中[Shift]: 急降下攻撃","color":"red"}','{"text":"CT: 8s","color":"aqua"}']}} 1

# 3. ブラッドクリスタル (更新)
item replace entity @s container.2 with minecraft:red_dye{berserker_raid:1b,display:{Name:'{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',Lore:['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']}} 1