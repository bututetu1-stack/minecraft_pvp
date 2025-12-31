# finalize_book_return: 1t遅延で未受領プレイヤーへ再給付

# 再給付対象プレイヤーに対して、まだ所持していなければ give
execute as @a[tag=book_needs_return] unless entity @s[nbt={Inventory:[{tag:{magician_book:1b}}]}] run give @s minecraft:book{magician_book:1b,display:{Name:'{"text":"魔術本","italic":false,"color":"gold","bold":true}',Lore:['{"text":"[Q]キー: 炎玉発射","color":"yellow"}','{"text":"Cost: 5 MANA","color":"gray"}','{"text":"ダメージ: ハート3個分","color":"red"}','{"text":"CT: 0s","color":"aqua"}']}} 1

# タグの掃除
tag @a remove book_needs_return
