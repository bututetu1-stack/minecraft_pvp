# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=tank] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却
# 【修正】攻撃速度 -3.5 のハンマーを返す
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{tank_hammer:1b}}]}] run give @s minecraft:iron_shovel{tank_hammer:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:2s}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;222,333,444,555],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.5,Operation:0,UUID:[I;222,333,444,556],Slot:"mainhand"}],display:{Name:'{"text":"タイタンハンマー","color":"gold","bold":true}',Lore:['{"text":"重量級の一撃","color":"gray"}']},HideFlags:2} 1

# 4. アイテム消去
kill @s