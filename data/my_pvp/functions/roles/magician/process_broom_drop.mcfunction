# 魔術箒ドロップ処理 (スキル発動)

# 1. 所有者を特定
tag @a remove item_recipient
execute as @a if score @s player_id = @e[type=item,tag=id_set,nbt={Item:{tag:{magician_broom:1b}}},limit=1,sort=nearest] player_id run tag @s add item_recipient

# 2. 所有者のもとでスキル発動
# 2. 所有者のもとでスキル発動
#    操作開始時の飛行状態を `was_flying` タグへ保存しておき、以降はこの値で分岐する
execute as @p[tag=item_recipient,tag=magician] if entity @s[tag=mag_flying] run tag @s add was_flying

# 飛行開始時に was_flying があれば着陸、なければ離陸（同一関数内での状態変化による競合を防止）
execute as @p[tag=item_recipient,tag=magician] if entity @s[tag=was_flying] unless entity @s[tag=mag_action_lock] run function my_pvp:roles/magician/land
execute as @p[tag=item_recipient,tag=magician] unless entity @s[tag=was_flying] unless entity @s[tag=mag_action_lock] run function my_pvp:roles/magician/use_broom

# 後片付け: was_flying タグをクリア
tag @a remove was_flying

# 3. 所有者に返却を試み（既に所持していなければ give）
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{magician_broom:1b}}]}] run tag @s add broom_needs_return
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{magician_broom:1b}}]}] run give @s minecraft:stick{magician_broom:1b,display:{Name:'{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',Lore:['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"飛行中: 通常=上昇 / Shift=下降","color":"white"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}']}} 1

# 4. ドロップエンティティを消す（給付処理はタグで追跡）
kill @s

# 5. 予備再給付（1tick後に未受領なら再給付）
schedule function my_pvp:roles/magician/finalize_broom_return 1t replace
