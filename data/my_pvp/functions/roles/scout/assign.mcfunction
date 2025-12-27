# 1. タグ付け
tag @s add scout
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『スカウト』","color":"aqua","bold":true},{"text":" です！","color":"white"}]

# 3. 初期化
scoreboard players set @s cd_wire 0
tag @s remove is_grappling

# 4. 音
playsound minecraft:entity.bat.takeoff master @s ~ ~ ~ 1 1.5