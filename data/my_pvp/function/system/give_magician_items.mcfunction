# --- 魔術師装備 ---

# 1. 魔術箒 (Slot 0)
item replace entity @s container.0 with minecraft:stick[minecraft:custom_data={magician_broom:1b},minecraft:custom_name='{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}']] 1

# 2. 魔術本 (Slot 1)
item replace entity @s container.1 with minecraft:book[minecraft:custom_data={magician_book:1b},minecraft:custom_name='{"text":"魔術本","italic":false,"color":"gold","bold":true}',minecraft:lore=['{"text":"[Q]キー: 炎玉発射","color":"yellow"}','{"text":"Cost: 5 MANA","color":"gray"}','{"text":"ダメージ: ハート2個分","color":"red"}','{"text":"CT: 0s","color":"aqua"}']] 1

# 3. 衝撃符 (Slot 2) — 近接衝撃波
item replace entity @s container.2 with minecraft:white_dye[minecraft:custom_data={magician_shockwave:1b},minecraft:custom_name='{"text":"衝撃符","italic":false,"color":"aqua","bold":true}',minecraft:lore=['{"text":"[Q]キー: 自分中心 半径4m に衝撃波","color":"yellow"}','{"text":"Cost: 15 MANA","color":"gray"}','{"text":"damage 8 + 強ノックバック + 鈍足II 2秒","color":"red"}','{"text":"CT: 5s","color":"aqua"}']] 1

# 4. 業火符 (Slot 3) — 範囲爆裂
item replace entity @s container.3 with minecraft:fire_charge[minecraft:custom_data={magician_inferno:1b},minecraft:custom_name='{"text":"業火符","italic":false,"color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー: 視線方向に魔法弾、着弾点半径5m爆発","color":"yellow"}','{"text":"Cost: 25 MANA","color":"gray"}','{"text":"damage 12 + 3秒燃焼","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1

# 5. 初期マナ
scoreboard players set @s mana 50

# 6. クールダウン初期化
scoreboard players set @s cd_mag_broom 0
scoreboard players set @s cd_mag_book 0
scoreboard players set @s cd_mag_shockwave 0
scoreboard players set @s cd_mag_inferno 0

# 5. 飛行状態初期化
tag @s remove mag_flying_true
scoreboard players set @s mag_fly_tick 0
