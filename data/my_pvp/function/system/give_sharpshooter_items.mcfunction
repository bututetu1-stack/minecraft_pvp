# 狙撃手装備
# slot 0: 集中スコープ (主武器、右クリ集中 + ドロップで通常弾発射)
item replace entity @s container.0 with minecraft:spyglass[minecraft:custom_data={sharpshooter_focus:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"集中スコープ","color":"aqua","bold":true,"italic":false}',minecraft:lore=['{"text":"右クリ保持: 集中状態 (鈍足II + 半径15敵発光)","color":"yellow"}','{"text":"[Q]キー(捨てる): 通常弾発射 (1弾)","color":"yellow"}','{"text":"距離20m貫通, ダメージ6","color":"gray"}']] 1

# slot 2: 強撃弾 (red_dye)
item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={sharpshooter_pierce:1b},minecraft:custom_name='{"text":"強撃弾","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 強撃弾発射 (3弾)","color":"yellow"}','{"text":"距離35m貫通, ダメージ14, 防御無視","color":"gray"}']] 1

# slot 3: マーキング弾 (charcoal)
item replace entity @s container.3 with minecraft:charcoal[minecraft:custom_data={sharpshooter_mark:1b},minecraft:custom_name='{"text":"マーキング弾","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): マーキング弾発射 (2弾)","color":"yellow"}','{"text":"距離25m貫通, 命中で5秒 発光+鈍足II + ダメ3","color":"gray"}']] 1
