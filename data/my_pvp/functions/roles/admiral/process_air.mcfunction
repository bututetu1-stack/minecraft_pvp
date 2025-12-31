# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=admiral] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (Slot 2)
# 変更点: LoreのCTを 30秒 に書き換え
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{adm_air:1b}}]}] run item replace entity @s container.2 with minecraft:carrot_on_a_stick{adm_air:1b,CustomModelData:3,display:{Name:'{"text":"【航空支援】","color":"red","bold":true}',Lore:['{"text":"[右クリック] 絨毯爆撃要請","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']},Unbreakable:1b} 1

# 4. アイテム消去
kill @s