# --- 座標記録 ---
function my_pvp:roles/chrono/record_position

# --- ドロップ検知 ---
function my_pvp:roles/chrono/scan_items

# --- クールダウン消化 ---
execute if score @s cd_chrono_reverse matches 1.. run scoreboard players remove @s cd_chrono_reverse 1
execute if score @s cd_chrono_stasis matches 1.. run scoreboard players remove @s cd_chrono_stasis 1
execute if score @s cd_chrono_clockup matches 1.. run scoreboard players remove @s cd_chrono_clockup 1

# --- アクションバー (並列表示) ---
# CTの合計を計算
scoreboard players operation #TEMP_CT temp = @s cd_chrono_reverse
scoreboard players operation #TEMP_CT temp += @s cd_chrono_stasis
scoreboard players operation #TEMP_CT temp += @s cd_chrono_clockup

# どれか一つでもCT中なら表示
execute if score #TEMP_CT temp matches 1.. run title @s actionbar [{"text":"Rev:","color":"aqua"},{"score":{"name":"@s","objective":"cd_chrono_reverse"},"color":"white"},{"text":" | ","color":"gray"},{"text":"Sts:","color":"yellow"},{"score":{"name":"@s","objective":"cd_chrono_stasis"},"color":"white"},{"text":" | ","color":"gray"},{"text":"Clk:","color":"red"},{"score":{"name":"@s","objective":"cd_chrono_clockup"},"color":"white"}]