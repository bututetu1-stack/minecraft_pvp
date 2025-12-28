# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=berserker] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (インベントリになければ返す)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{berserker_axe:1b}}]}] run give @s minecraft:iron_axe{berserker_axe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:7,Operation:0,UUID:[I;333,444,555,666],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.0,Operation:0,UUID:[I;333,444,555,667],Slot:"mainhand"}],display:{Name:'{"text":"ブラッドアックス","color":"red","bold":true}',Lore:['{"text":"攻撃力: 8 (重量級)","color":"gray"}']},HideFlags:2} 1

# 4. アイテム消去
kill @s