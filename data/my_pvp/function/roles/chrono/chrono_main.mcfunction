# --- タイム・リバース後の最大HP復帰 (restore_hp の次のtick) ---
execute if entity @s[tag=chrono_restore_max] run tag @s remove ignore_status_check
execute if entity @s[tag=chrono_restore_max] run attribute @s minecraft:max_health base set 40
tag @s remove chrono_restore_max

# --- 座標記録 ---
function my_pvp:roles/chrono/record_position

# --- ドロップ検知 ---
function my_pvp:roles/chrono/scan_items

# --- クールダウン消化 ---
execute if score @s cd_chrono_reverse matches 1.. run scoreboard players remove @s cd_chrono_reverse 1
execute if score @s cd_chrono_stasis matches 1.. run scoreboard players remove @s cd_chrono_stasis 1
execute if score @s cd_chrono_clockup matches 1.. run scoreboard players remove @s cd_chrono_clockup 1

# 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump

# --- アクションバー (常時表示) ---
# 条件分岐を削除し、CTが0の状態でも常に表示するように変更
title @s actionbar [{"text":"Rev:","color":"aqua"},{"score":{"name":"@s","objective":"cd_chrono_reverse"},"color":"white"},{"text":" | ","color":"gray"},{"text":"Sts:","color":"yellow"},{"score":{"name":"@s","objective":"cd_chrono_stasis"},"color":"white"},{"text":" | ","color":"gray"},{"text":"Clk:","color":"red"},{"score":{"name":"@s","objective":"cd_chrono_clockup"},"color":"white"}]