# 魔術本ドロップ処理 (スキル発動)

# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{tag:{magician_book:1b}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者のもとでスキル発動
# 既にアクションロックを持っている場合は二重発火防止のため呼ばない
execute as @p[tag=item_recipient,tag=magician] at @s unless entity @s[tag=mag_action_lock] run function my_pvp:roles/magician/use_book

# 3. 所有者に返却を試み（既に所持していなければ give）
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{magician_book:1b}}]}] run tag @s add book_needs_return
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{magician_book:1b}}]}] run give @s minecraft:book{magician_book:1b,display:{Name:'{"text":"魔術本","italic":false,"color":"gold","bold":true}',Lore:['{"text":"[Q]キー: 炎玉発射","color":"yellow"}','{"text":"Cost: 5 MANA","color":"gray"}','{"text":"ダメージ: ハート3個分","color":"red"}','{"text":"CT: 0s","color":"aqua"}']}} 1

# 4. ドロップエンティティを消す（給付処理はタグで追跡）
kill @s

# 5. 予備再給付（1tick後に未受領なら再給付）
schedule function my_pvp:roles/magician/finalize_book_return 1t replace
