# finalize_broom_return: 1t遅延で未受領プレイヤーへ再給付

# 再給付対象プレイヤーに対して、まだ所持していなければ give
execute as @a[tag=broom_needs_return] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{magician_broom:1b}}}]}] run give @s minecraft:stick[custom_name='{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',lore=['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}'],custom_data={magician_broom:1b}] 1

# タグの掃除
tag @a remove broom_needs_return
