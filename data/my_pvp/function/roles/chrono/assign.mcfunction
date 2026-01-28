# 1. タグ付け
tag @s add chrono
scoreboard players set @s role_id 9
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『時空跳躍者』","color":"yellow","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
function my_pvp:roles/chrono/apply_status

# 4. 初期化
scoreboard players set @s timer 0
# 【変更】 個別CTをリセット
scoreboard players set @s cd_chrono_reverse 0
scoreboard players set @s cd_chrono_stasis 0
scoreboard players set @s cd_chrono_clockup 0

# 任命サウンド
execute at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 2