# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=admiral] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (Slot 1)
# Tag: adm_torpedo, CMD: 2
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{adm_torpedo:1b}}]}] run item replace entity @s container.1 with minecraft:carrot_on_a_stick{adm_torpedo:1b,CustomModelData:2,display:{Name:'{"text":"【魚雷カットイン】","color":"aqua","bold":true}',Lore:['{"text":"[右クリック] 扇状に魚雷発射","color":"yellow"}','{"text":"CT: 10秒","color":"gray"}']},Unbreakable:1b} 1

# 4. アイテム消去
kill @s