# 1. タグ付け
tag @s add samurai
scoreboard players set @s role_id 12
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『侍』","color":"dark_blue","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
function my_pvp:roles/samurai/apply_status

# 4. クールダウン初期化
scoreboard players set @s cd_sam_zanshin 0
scoreboard players set @s cd_sam_iai 0
scoreboard players set @s cd_sam_hien 0
scoreboard players set @s sam_zanshin_active 0
scoreboard players set @s sam_iai_active 0

# 5. 音
execute at @s run playsound minecraft:item.trident.return master @s ~ ~ ~ 1 1.5
