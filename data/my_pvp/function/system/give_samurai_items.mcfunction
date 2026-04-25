# --- 侍装備 ---

# 1. 刀 (鉄の剣) - 攻撃力7, 攻撃速度1.6
item replace entity @s container.0 with minecraft:iron_sword[minecraft:custom_data={samurai_katana:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:6.0,operation:"add_value",slot:"mainhand",id:"my_pvp:samurai_katana_damage"},{type:"attack_speed",amount:-2.4,operation:"add_value",slot:"mainhand",id:"my_pvp:samurai_katana_speed"}],show_in_tooltip:false},minecraft:custom_name='{"text":"刀","color":"red","bold":true}',minecraft:lore=['{"text":"攻撃力: 7","color":"gray"}','{"text":"一閃の太刀筋","color":"dark_red"}']] 1

# 2. 残心 (Zanshin) - パリィ用の盾 (右クリック構え)
item replace entity @s container.1 with minecraft:shield[minecraft:custom_data={samurai_zanshin:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"残心","color":"aqua","bold":true}',minecraft:lore=['{"text":"右クリック長押し: 構え","color":"gray"}','{"text":"構え中に被弾で反撃斬撃","color":"yellow"}','{"text":"CT: 8s","color":"aqua"}']] 1

# 3. 居合 (Iai) - 前方ダッシュ斬撃 [Q]
item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={samurai_iai:1b},minecraft:custom_name='{"text":"居合","color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 居合斬り","color":"yellow"}','{"text":"前方へ突進し貫通ダメージ","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1

# 4. 飛燕 (Hien) - 三段ジャンプ斬撃 [Q]
item replace entity @s container.3 with minecraft:feather[minecraft:custom_data={samurai_hien:1b},minecraft:custom_name='{"text":"飛燕","color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 三段ジャンプ斬撃","color":"yellow"}','{"text":"上昇しながら周囲を斬る","color":"red"}','{"text":"CT: 12s","color":"aqua"}']] 1
