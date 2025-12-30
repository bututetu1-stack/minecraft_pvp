# 1. タグ付け
tag @s add magician
tag @s add role_assigned

# 2. チャットで通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『魔術師』","color":"light_purple","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
attribute @s minecraft:generic.attack_damage base set 1

# 4. マナ初期化
scoreboard players set @s mana 50

# 5. クールダウン初期化
scoreboard players set @s cd_mag_broom 0
scoreboard players set @s cd_mag_book 0

# 6. 飛行状態初期化
tag @s remove mag_flying_true
tag @s add mag_flying_false

# 7. 効果音
playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 1 1
