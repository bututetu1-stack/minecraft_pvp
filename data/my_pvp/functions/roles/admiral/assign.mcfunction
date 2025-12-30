# 1. タグ付け
tag @s add admiral
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『提督』","color":"dark_aqua","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
function my_pvp:roles/admiral/apply_status

# 【追加】 クールダウン初期化
scoreboard players set @s cd_adm_artillery 0
scoreboard players set @s cd_adm_torpedo 0
scoreboard players set @s cd_adm_air 0
scoreboard players set @s cd_adm_aa 0

# 4. 音
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.5
playsound minecraft:item.trident.thunder master @s ~ ~ ~ 1 2