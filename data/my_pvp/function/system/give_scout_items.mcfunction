# 1. ワイヤーボウ
give @s minecraft:bow[minecraft:custom_data={Tags:["scout_bow"]},minecraft:custom_name='{"text":"ワイヤーボウ","color":"aqua","bold":true}',minecraft:lore=['{"text":"着弾地点まで高速移動","color":"gray"}','{"text":"Sneak: 移動キャンセル","color":"yellow"}','{"text":"CT: なし","color":"aqua"}'],minecraft:unbreakable={},minecraft:enchantments={levels:{"minecraft:infinity":1}}] 1

# 2. リパルサーブレード
# 【修正】Amount:3 -> 5 (合計攻撃力 4 -> 6)
give @s minecraft:iron_sword[minecraft:custom_data={scout_sword:1b},minecraft:unbreakable={},minecraft:enchantments={levels:{"minecraft:knockback":1}},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:5.0,operation:"add_value",slot:"mainhand",id:"my_pvp:scout_sword_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"リパルサーブレード","color":"white"}',minecraft:lore=['{"text":"攻撃力: 6 (固定)","color":"gray"}']] 1

# 3. 矢
give @s minecraft:arrow[minecraft:custom_data={scout_arrow:1b},minecraft:custom_name='{"text":"矢 (無限)","color":"white"}'] 1