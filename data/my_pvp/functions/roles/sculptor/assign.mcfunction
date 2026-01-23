# 1. 役職タグ設定
tag @s add sculptor
tag @s add role_assigned

# 2. チャットで通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『彫刻家』","color":"blue","bold":true},{"text":" です！","color":"white"}]

# 3. インベントリ初期化
clear @s

# 4. 変数初期化
scoreboard players set @s sculpture_count 0
scoreboard players set @s sculpture_cycle 1
scoreboard players set @s cd_sculptor_create 0

# 5. 音
execute at @s run playsound minecraft:block.anvil.use master @s ~ ~ ~ 1 0.8
