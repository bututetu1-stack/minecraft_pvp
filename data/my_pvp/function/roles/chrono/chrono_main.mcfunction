# --- 座標記録 ---
function my_pvp:roles/chrono/record_position

# --- ドロップ検知 ---
function my_pvp:roles/chrono/scan_items

# --- CT終了時のアイテム自動返却 (バーサーカーパターン) ---
# タイム・リバース (slot 1)
execute as @s[scores={cd_chrono_reverse=1}] run item replace entity @s container.1 with minecraft:light_blue_dye[minecraft:custom_data={chrono_reverse:1b},minecraft:custom_name='{"text":"<< タイム・リバース","color":"aqua","italic":false}',minecraft:lore=['{"text":"[Qキー] 5秒前の位置とHPに戻る","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}']] 1
execute as @s[scores={cd_chrono_reverse=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 1.5

# 時空の静止 (slot 2)
execute as @s[scores={cd_chrono_stasis=1}] run item replace entity @s container.2 with minecraft:yellow_dye[minecraft:custom_data={chrono_stasis:1b},minecraft:custom_name='{"text":"|| 時空の静止","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1
execute as @s[scores={cd_chrono_stasis=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# クロック・アップ (slot 3)
execute as @s[scores={cd_chrono_clockup=1}] run item replace entity @s container.3 with minecraft:red_dye[minecraft:custom_data={chrono_clockup:1b},minecraft:custom_name='{"text":">> クロック・アップ","color":"red","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、超高速移動","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1
execute as @s[scores={cd_chrono_clockup=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 0.8

# Rush Mode Safety (ラッシュ中にCT0なのにアイテム無い場合は即時再配布)
execute as @s[tag=rush_mode,scores={cd_chrono_reverse=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{chrono_reverse:1b}}}]}] run item replace entity @s container.1 with minecraft:light_blue_dye[minecraft:custom_data={chrono_reverse:1b},minecraft:custom_name='{"text":"<< タイム・リバース","color":"aqua","italic":false}',minecraft:lore=['{"text":"[Qキー] 5秒前の位置とHPに戻る","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}']] 1
execute as @s[tag=rush_mode,scores={cd_chrono_stasis=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{chrono_stasis:1b}}}]}] run item replace entity @s container.2 with minecraft:yellow_dye[minecraft:custom_data={chrono_stasis:1b},minecraft:custom_name='{"text":"|| 時空の静止","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1
execute as @s[tag=rush_mode,scores={cd_chrono_clockup=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{chrono_clockup:1b}}}]}] run item replace entity @s container.3 with minecraft:red_dye[minecraft:custom_data={chrono_clockup:1b},minecraft:custom_name='{"text":">> クロック・アップ","color":"red","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、超高速移動","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1

# --- クールダウン消化 ---
execute if score @s cd_chrono_reverse matches 1.. run scoreboard players remove @s cd_chrono_reverse 1
execute if score @s cd_chrono_stasis matches 1.. run scoreboard players remove @s cd_chrono_stasis 1
execute if score @s cd_chrono_clockup matches 1.. run scoreboard players remove @s cd_chrono_clockup 1

# 役職固有 上昇スキル: 時空跳躍
execute if score @s cd_chrono_jump matches 1.. run scoreboard players remove @s cd_chrono_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/chrono/use_jump

# --- アクションバー (常時表示) ---
# 条件分岐を削除し、CTが0の状態でも常に表示するように変更
title @s actionbar [{"text":"Rev:","color":"aqua"},{"score":{"name":"@s","objective":"cd_chrono_reverse"},"color":"white"},{"text":" | ","color":"gray"},{"text":"Sts:","color":"yellow"},{"score":{"name":"@s","objective":"cd_chrono_stasis"},"color":"white"},{"text":" | ","color":"gray"},{"text":"Clk:","color":"red"},{"score":{"name":"@s","objective":"cd_chrono_clockup"},"color":"white"}]
