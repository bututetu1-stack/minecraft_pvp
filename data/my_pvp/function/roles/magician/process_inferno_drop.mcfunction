# 業火符ドロップ処理 (スキル発動)

# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{components:{"minecraft:custom_data":{magician_inferno:1b}}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者のもとでスキル発動 (CT/MPチェックは use_inferno 内で実施)
execute as @p[tag=item_recipient,tag=magician] at @s run function my_pvp:roles/magician/use_inferno

# 3. アイテム返却 (常に返す)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_inferno:1b}}}]}] run item replace entity @s container.3 with minecraft:fire_charge[minecraft:custom_data={magician_inferno:1b},minecraft:custom_name='{"text":"業火符","italic":false,"color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー: 視線方向に魔法弾、着弾点半径5m爆発","color":"yellow"}','{"text":"Cost: 25 MANA","color":"gray"}','{"text":"damage 12 + 3秒燃焼","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1

# 4. ドロップエンティティを消す
kill @s
