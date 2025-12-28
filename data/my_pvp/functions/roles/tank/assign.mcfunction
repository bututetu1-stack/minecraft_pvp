# 1. タグ付け
tag @s add tank
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『タンク』","color":"dark_green","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定 (関数呼び出しに変更)
function my_pvp:roles/tank/apply_status

# 5. 音
playsound minecraft:entity.iron_golem.repair master @s ~ ~ ~ 1 1