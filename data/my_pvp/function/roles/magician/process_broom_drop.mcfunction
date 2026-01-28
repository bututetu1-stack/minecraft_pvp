# 魔術箒ドロップ処理 (スキル発動)

# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{components:{"minecraft:custom_data":{magician_broom:1b}}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者のもとでスキル発動（アクションロックがあれば無視）
# 処理は `use_broom` に一本化して、離陸/着陸の判定とロック管理を集中させる
execute as @p[tag=item_recipient,tag=magician] unless entity @s[tag=mag_action_lock] run function my_pvp:roles/magician/use_broom

# 3. 所有者に返却を試み（既に所持していなければ give）
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_broom:1b}}}]}] run tag @s add broom_needs_return
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_broom:1b}}}]}] run give @s minecraft:stick[minecraft:custom_data={magician_broom:1b},minecraft:custom_name='{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}']] 1

# 4. ドロップエンティティを消す（給付処理はタグで追跡）
kill @s

# 5. 予備再給付（1tick後に未受領なら再給付）
schedule function my_pvp:roles/magician/finalize_broom_return 1t replace
