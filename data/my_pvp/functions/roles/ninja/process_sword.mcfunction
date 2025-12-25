# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 持ち主特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. 新品を配布 (NBTは give_ninja_items と同じ)
execute as @a[tag=item_recipient] run give @s minecraft:iron_sword{ninja_sword:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4,Operation:0,UUID:[I;114,514,1919,810],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-2.4,Operation:0,UUID:[I;114,514,1919,811],Slot:"mainhand"}],display:{Name:'{"text":"忍刀","color":"white"}',Lore:['{"text":"攻撃力: 中","color":"gray"}']},HideFlags:2} 1

# 4. エンティティ消去
kill @s