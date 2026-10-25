# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=stalker] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (slot 1 に固定配置 / update_compass が次tick以降に座標更新)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{is_tracking_compass:1b}}}]}] run item replace entity @s container.1 with minecraft:compass[minecraft:custom_data={is_tracking_compass:1b},minecraft:lodestone_tracker={target:{dimension:"minecraft:overworld",pos:[I;0,0,0]},tracked:false},minecraft:custom_name='{"text":"追跡のコンパス","italic":false,"color":"gold"}'] 1
# 変化検知をリセット (次tickで強制更新させる)
execute as @a[tag=item_recipient] run scoreboard players set @s last_compass_x 999999
execute as @a[tag=item_recipient] run scoreboard players set @s last_compass_z 999999

# 4. アイテム消去
kill @s