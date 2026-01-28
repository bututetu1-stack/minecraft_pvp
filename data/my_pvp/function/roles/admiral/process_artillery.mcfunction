# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=admiral] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (Slot 0)
# 修正: CT表記を 20秒 に変更
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{adm_artillery:1b}}}]}] run item replace entity @s container.0 with minecraft:carrot_on_a_stick[minecraft:custom_data={adm_artillery:1b},minecraft:custom_model_data={floats:[1.0]},minecraft:custom_name='{"text":"【砲撃支援】","color":"gold","bold":true}',minecraft:lore=['{"text":"[右クリック] 指定地点へ砲撃","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}'],minecraft:unbreakable={}] 1

# 4. アイテム消去
kill @s