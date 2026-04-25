# 残心(盾): 投げ禁止 → 即回収
data merge entity @s {PickupDelay:0s}

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=samurai] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 既に持っていない場合のみ返却
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{samurai_zanshin:1b}}}]}] run item replace entity @s container.1 with minecraft:shield[minecraft:custom_data={samurai_zanshin:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"残心","color":"aqua","bold":true}',minecraft:lore=['{"text":"右クリック長押し: 構え","color":"gray"}','{"text":"構え中に被弾で反撃斬撃","color":"yellow"}','{"text":"CT: 8s","color":"aqua"}']] 1

kill @s
