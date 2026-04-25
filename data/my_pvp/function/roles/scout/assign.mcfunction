# 1. タグ付け
tag @s add scout
scoreboard players set @s role_id 3
tag @s add role_assigned

# 2. 通知
# 【修正】表示名を「立体機動兵」に変更
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『立体機動兵』","color":"aqua","bold":true},{"text":" です！","color":"white"}]

# 3. 初期化
scoreboard players set @s cd_wire 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0
tag @s remove is_grappling

# 4. 音
execute at @s run playsound minecraft:entity.bat.takeoff master @s ~ ~ ~ 1 1.5