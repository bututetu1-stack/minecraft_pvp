clear @s

# 1. メイン武器
item replace entity @s container.0 with minecraft:iron_sword[minecraft:custom_data={chrono_sword:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"刻の宝剣","color":"yellow","italic":false}']

# 2. タイム・リバース (5秒前)
item replace entity @s container.1 with minecraft:light_blue_dye[minecraft:custom_data={chrono_reverse:1b},minecraft:custom_name='{"text":"<< タイム・リバース","color":"aqua","italic":false}',minecraft:lore=['{"text":"[Qキー] 5秒前の位置とHPに戻る","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}']] 1

# 3. 時空の静止 (10秒)
item replace entity @s container.2 with minecraft:yellow_dye[minecraft:custom_data={chrono_stasis:1b},minecraft:custom_name='{"text":"|| 時空の静止","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1

# 4. クロック・アップ (10秒)
item replace entity @s container.3 with minecraft:red_dye[minecraft:custom_data={chrono_clockup:1b},minecraft:custom_name='{"text":">> クロック・アップ","color":"red","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、超高速移動","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1