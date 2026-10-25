# --- バーサーカー装備 ---

# 1. ブラッドアックス
item replace entity @s container.0 with minecraft:iron_axe[minecraft:custom_data={berserker_axe:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:7.0,operation:"add_value",slot:"mainhand",id:"my_pvp:berserker_axe_damage"},{type:"attack_speed",amount:-3.0,operation:"add_value",slot:"mainhand",id:"my_pvp:berserker_axe_speed"}],show_in_tooltip:false},minecraft:custom_name='{"text":"ブラッドアックス","color":"red","bold":true}',minecraft:lore=['{"text":"攻撃力: 8 (重量級)","color":"gray"}']] 1

# 2. リープフェザー (更新)
item replace entity @s container.1 with minecraft:feather[minecraft:custom_data={berserker_jump:1b},minecraft:custom_name='{"text":"リープフェザー","color":"green","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"着地時に衝撃波 (Cost: 4HP)","color":"red"}','{"text":"空中[Shift]: 急降下 (衝撃波強化)","color":"red"}','{"text":"CT: 8s","color":"aqua"}']] 1

# 3. ブラッドクリスタル (更新)
item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={berserker_raid:1b},minecraft:custom_name='{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']] 1