# 1. 拾われないように保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 持ち主を特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=mechanic] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. 【修正】アイテム返却（スロット指定）
# すでにレンチを持っていない場合のみ実行
# container.4 (ホットバーの5番目) に強制的に配置します
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{is_wrench:1b}}}]}] run item replace entity @s container.4 with minecraft:iron_axe[minecraft:custom_data={is_wrench:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:-100.0,operation:"add_value",slot:"mainhand",id:"my_pvp:no_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"エンジニアレンチ","italic":false,"color":"white"}',minecraft:lore=['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"左クリック: 解体 (Return: 2)","color":"gray"}']] 1

# 4. エンティティ消去
kill @s