# 彫刻刀（鉄の剣）を配布
# slot 0: 彫刻刀
item replace entity @s container.0 with minecraft:iron_sword[minecraft:custom_data={sculptor_chisel:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:4.0,operation:"add_value",slot:"mainhand",id:"my_pvp:sculptor_chisel_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"彫刻刀","color":"blue","italic":false}',minecraft:lore=['{"text":"捨てると彫刻を召喚","color":"gray"}','{"text":"最大20個まで設置可能","color":"aqua"}']] 1

# slot 1: 石化光線 (新攻撃スキル)
item replace entity @s container.1 with minecraft:amethyst_shard[minecraft:custom_data={sculptor_beam:1b},minecraft:custom_name='{"text":"石化光線","color":"blue","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 石化光線発射","color":"yellow"}','{"text":"視線方向12m先まで貫通、命中で6ダメ + 鈍足IV","color":"gray"}','{"text":"CT: 10s","color":"aqua"}']] 1
