# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却
# 矢は消耗品扱いですが、無限弓運用のため「1本も持っていなければ」返します
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{scout_arrow:1b}}}]}] run give @s minecraft:arrow[minecraft:custom_data={scout_arrow:1b},minecraft:custom_name='{"text":"矢 (無限)","color":"white"}'] 1

# 4. アイテム消去
kill @s