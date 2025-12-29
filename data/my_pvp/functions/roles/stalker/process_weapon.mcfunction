# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=stalker] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (持っていない場合のみ)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{is_stalker_weapon:1b}}]}] run give @s minecraft:iron_sword{is_stalker_weapon:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Amount:3.0d,Operation:0,Slot:"mainhand",UUID:[I;111,222,333,444],Name:"weak_damage"}],display:{Name:'{"text":"凶手の剣","italic":false,"color":"dark_red"}',Lore:['{"text":"ターゲット以外には弱い","color":"gray"}']}} 1

# 4. アイテム消去
kill @s