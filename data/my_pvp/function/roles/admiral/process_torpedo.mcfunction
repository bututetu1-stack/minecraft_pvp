# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=admiral] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (Slot 1)
# 修正: 説明文を「前方へ3連」に変更
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{adm_torpedo:1b}}}]}] run item replace entity @s container.1 with minecraft:carrot_on_a_stick[minecraft:custom_data={adm_torpedo:1b},minecraft:custom_model_data=2,minecraft:custom_name='{"text":"【魚雷カットイン】","color":"aqua","bold":true}',minecraft:lore=['{"text":"[右クリック] 前方へ3連魚雷","color":"yellow"}','{"text":"CT: 10秒","color":"gray"}'],minecraft:unbreakable={}] 1

# 4. アイテム消去
kill @s