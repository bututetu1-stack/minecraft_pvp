# 1. タグ付け
tag @s add sharpshooter
scoreboard players set @s role_id 13
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『狙撃手』","color":"dark_gray","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
function my_pvp:roles/sharpshooter/apply_status

# 4. クールダウン初期化
scoreboard players set @s cd_sharp_snipe 0
scoreboard players set @s cd_sharp_smoke 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0

# 5. 攻撃力初期化 (素手は弱い、弓に依存)
attribute @s minecraft:attack_damage base set 1

# 6. 音
execute at @s run playsound minecraft:item.armor.equip_chain master @s ~ ~ ~ 1 1.5
execute at @s run playsound minecraft:entity.arrow.shoot master @s ~ ~ ~ 0.7 0.5
