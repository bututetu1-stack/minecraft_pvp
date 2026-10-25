# 衝撃符ドロップ処理 (スキル発動)

# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{components:{"minecraft:custom_data":{magician_shockwave:1b}}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者のもとでスキル発動 (CT/MPチェックは use_shockwave 内で実施)
execute as @p[tag=item_recipient,tag=magician] at @s run function my_pvp:roles/magician/use_shockwave

# 3. アイテム返却 (常に返す)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_shockwave:1b}}}]}] run item replace entity @s container.2 with minecraft:white_dye[minecraft:custom_data={magician_shockwave:1b},minecraft:custom_name='{"text":"衝撃符","italic":false,"color":"aqua","bold":true}',minecraft:lore=['{"text":"[Q]キー: 自分中心 半径4m に衝撃波","color":"yellow"}','{"text":"Cost: 15 MANA","color":"gray"}','{"text":"damage 8 + 強ノックバック + 鈍足II 2秒","color":"red"}','{"text":"CT: 5s","color":"aqua"}']] 1

# 4. ドロップエンティティを消す
kill @s
