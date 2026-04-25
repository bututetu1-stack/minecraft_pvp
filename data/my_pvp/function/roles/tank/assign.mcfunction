# 1. タグ付け
tag @s add tank
scoreboard players set @s role_id 4
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『タンク』","color":"dark_green","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定 (関数呼び出しに変更)
function my_pvp:roles/tank/apply_status

# 4. クールダウン初期化
scoreboard players set @s cd_tank_crash 0
scoreboard players set @s cd_shield_bash 0
scoreboard players set @s shield_dash_timer 0

# 5. 音
execute at @s run playsound minecraft:entity.iron_golem.repair master @s ~ ~ ~ 1 1
