clear @s

# 1. メイン武器
item replace entity @s container.0 with minecraft:iron_sword{Unbreakable:1b,display:{Name:'{"text":"刻の宝剣","color":"yellow","italic":false}'}}

# 2. タイム・リバース (5秒前)
item replace entity @s container.1 with minecraft:light_blue_dye{chrono_reverse:1b,display:{Name:'{"text":"<< タイム・リバース","color":"aqua","italic":false}',Lore:['{"text":"[Qキー] 5秒前の位置とHPに戻る","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}']}} 1

# 3. 時空の静止 (10秒)
item replace entity @s container.2 with minecraft:yellow_dye{chrono_stasis:1b,display:{Name:'{"text":"|| 時空の静止","color":"yellow","italic":false}',Lore:['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']}} 1

# 4. クロック・アップ (10秒)
item replace entity @s container.3 with minecraft:red_dye{chrono_clockup:1b,display:{Name:'{"text":">> クロック・アップ","color":"red","italic":false}',Lore:['{"text":"[Qキー] 10秒間、超高速移動","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']}} 1