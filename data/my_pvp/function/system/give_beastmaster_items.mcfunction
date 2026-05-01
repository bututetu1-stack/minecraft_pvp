# 獣使い装備
# slot 0: 鞭 (iron_sword 弱化, 攻撃力 3 + slowness 付与)
item replace entity @s container.0 with minecraft:iron_sword[minecraft:custom_data={beast_whip:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:2.0,operation:"add_value",slot:"mainhand",id:"my_pvp:beast_whip_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"鞭","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"攻撃力: 3","color":"gray"}','{"text":"命中で敵に slowness 1秒","color":"yellow"}']] 1

# slot 1: 狼の召喚 (骨)
item replace entity @s container.1 with minecraft:bone[minecraft:custom_data={beast_wolf:1b},minecraft:custom_name='{"text":"狼の呼び声","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 狼を召喚 (最大5匹)","color":"yellow"}','{"text":"接触damage 2/sec, HP25 (5発で死亡)","color":"gray"}','{"text":"CT: 12s","color":"aqua"}']] 1

# slot 2: 獣の咆哮 (ガストの涙 - 神秘的)
item replace entity @s container.2 with minecraft:ghast_tear[minecraft:custom_data={beast_roar:1b},minecraft:custom_name='{"text":"獣の咆哮","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分+召喚獣に強化 5秒","color":"yellow"}','{"text":"strength I + speed I","color":"gray"}','{"text":"CT: 18s","color":"aqua"}']] 1

# slot 3: 解き放つ (レッドストーン)
item replace entity @s container.3 with minecraft:redstone[minecraft:custom_data={beast_unleash:1b},minecraft:custom_name='{"text":"解き放つ","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 全召喚獣を即時自爆","color":"yellow"}','{"text":"各位置で半径3 damage 5 + KB","color":"gray"}','{"text":"CT: 20s","color":"aqua"}']] 1
