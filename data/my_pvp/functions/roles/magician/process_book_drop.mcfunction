# 魔術本ドロップ処理 (スキル発動)

# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{tag:{magician_book:1b}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者のもとでスキル発動
execute as @p[tag=item_recipient,tag=magician] at @s run function my_pvp:roles/magician/use_book

# 3. ドロップしたアイテムを消す
kill @s
