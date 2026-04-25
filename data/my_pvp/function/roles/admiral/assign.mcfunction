# 1. タグ付け
tag @s add admiral
scoreboard players set @s role_id 8
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
scoreboard players set @s cd_formation 0
scoreboard players set @s adm_formation 0
scoreboard players set @s ammo 0
scoreboard players set @s penalty_timer 0
scoreboard players set @s penalty_dmg 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0
scoreboard players set @s cd_adm_jump 0

# 4. 音
execute at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.5
execute at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 1 2