# 1. 拾われないように保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 持ち主を特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=mechanic] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. 【修正】アイテム配布（重複防止 & 性能統一）
# give_mechanic_items と全く同じコマンドを使用します
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{is_wrench:1b}}]}] run give @s minecraft:iron_axe{is_wrench:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Amount:0,Operation:0,Slot:"mainhand",UUID:[I;123,456,789,0],Name:"no_damage"}],display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"スニーク+右クリック: 解体 (Return: 2)","color":"gray"}']}} 1

# 4. エンティティ消去
kill @s