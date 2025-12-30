# finalize_broom_return: 1t遅延で未受領プレイヤーへ再給付

# 再給付対象プレイヤーに対して、まだ所持していなければ give
execute as @a[tag=broom_needs_return] unless entity @s[nbt={Inventory:[{tag:{magician_broom:1b}}]}] run give @s minecraft:stick{magician_broom:1b,display:{Name:'{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',Lore:['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 1s","color":"aqua"}']}} 1

# タグの掃除
tag @a remove broom_needs_return
