# 狙撃手装備
# slot 0: 弓 (無限矢)
item replace entity @s container.0 with minecraft:bow[minecraft:custom_data={sharpshooter_bow:1b},minecraft:enchantments={levels:{"minecraft:infinity":1}},minecraft:unbreakable={},minecraft:custom_name='{"text":"狙撃銃","color":"dark_gray","bold":true,"italic":false}',minecraft:lore=['{"text":"無限矢","color":"gray"}','{"text":"集中中はダメージ +50%","color":"yellow"}']] 1

# slot 1: スコープ用望遠鏡 (右クリ保持で集中)
item replace entity @s container.1 with minecraft:spyglass[minecraft:custom_data={sharpshooter_focus:1b},minecraft:custom_name='{"text":"集中スコープ","color":"aqua","bold":true,"italic":false}',minecraft:lore=['{"text":"右クリ保持: 集中状態","color":"yellow"}','{"text":"  狙い安定 (鈍足II)","color":"gray"}','{"text":"  半径15内の敵に発光","color":"gray"}','{"text":"  矢ダメージ +50%","color":"gray"}']] 1

# slot 2: 狙撃弾
item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={sharpshooter_snipe:1b},minecraft:custom_name='{"text":"狙撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 視線方向に貫通弾","color":"yellow"}','{"text":"距離30m, ダメージ8","color":"gray"}','{"text":"CT: 14s","color":"aqua"}']] 1

# slot 3: 煙幕弾
item replace entity @s container.3 with minecraft:charcoal[minecraft:custom_data={sharpshooter_smoke:1b},minecraft:custom_name='{"text":"煙幕弾","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分に煙幕展開","color":"yellow"}','{"text":"自分: invisibility 4s","color":"gray"}','{"text":"周囲: blindness 3s","color":"gray"}','{"text":"CT: 22s","color":"aqua"}']] 1

# 矢 (1本だけ持たせる、無限弓なので消費しない)
item replace entity @s container.8 with minecraft:arrow 1
