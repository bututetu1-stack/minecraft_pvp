# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (持っていない場合のみ)
# 【修正】AttributeModifiersからattack_speedを削除
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{ninja_sword:1b}}]}] run give @s minecraft:iron_sword{ninja_sword:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:3,Operation:0,UUID:[I;114,514,1919,810],Slot:"mainhand"}],display:{Name:'{"text":"忍刀","color":"white"}',Lore:['{"text":"攻撃力: 4 (固定)","color":"gray"}']},HideFlags:2} 1

# 4. アイテム消去
kill @s