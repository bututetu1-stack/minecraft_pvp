# 1. タイタンハンマー (鉄のシャベル)
# 攻撃力: 7 (ダイヤ剣相当), 攻撃速度: 遅い, ノックバックII
# 1. タイタンハンマー (鉄のシャベル)
# 攻撃力: 7 (ダイヤ剣相当), 攻撃速度: 遅い, ノックバックII
# 【修正】攻撃速度を -2.8 -> -3.5 に変更 (攻撃速度 0.5 = 2秒に1回)
execute unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_hammer:1b}}}]}] run give @s minecraft:iron_shovel[minecraft:custom_data={tank_hammer:1b},minecraft:unbreakable={},minecraft:enchantments={levels:{"minecraft:knockback":2}},minecraft:attribute_modifiers={modifiers:[{type:"generic.attack_damage",amount:9.0,operation:"add_value",slot:"mainhand",id:"my_pvp:tank_hammer_damage"},{type:"generic.attack_speed",amount:-2.5,operation:"add_value",slot:"mainhand",id:"my_pvp:tank_hammer_speed"},{type:"generic.knockback_resistance",amount:1.0,operation:"add_value",slot:"mainhand",id:"my_pvp:tank_hammer_kb_res"}],show_in_tooltip:false},minecraft:custom_name='{"text":"タイタンハンマー","color":"gold","bold":true}',minecraft:lore=['{"text":"不動の要塞","color":"gray"}']] 1
# 2. アースクラッシュ (スキル)
execute unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_skill:1b}}}]}] run give @s minecraft:warped_fungus_on_a_stick[minecraft:custom_data={tank_skill:1b},minecraft:custom_name='{"text":"アースクラッシュ","color":"green","bold":true}',minecraft:lore=['{"text":"右クリック: 周囲を吹き飛ばす","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={}] 1

# 3. シールドバッシュ (盾)
# [Q]キーでドロップして突進
execute unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_shield:1b}}}]}] run give @s minecraft:paper[minecraft:custom_model_data=1,minecraft:custom_data={tank_shield:1b},minecraft:custom_name='{"text":"シールドバッシュ","color":"blue","bold":true}',minecraft:lore=['{"text":"[Q]キーでドロップして突進 (2s)","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={}] 1
