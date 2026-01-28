# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=tank] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却
# 既にインベントリに「tank_skill」がある場合は渡さない
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_skill:1b}}}]}] run give @s minecraft:warped_fungus_on_a_stick[minecraft:custom_data={tank_skill:1b},minecraft:custom_name='{"text":"アースクラッシュ","color":"green","bold":true}',minecraft:lore=['{"text":"右クリック: 周囲を吹き飛ばす","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={}] 1

# 4. アイテム消去
kill @s