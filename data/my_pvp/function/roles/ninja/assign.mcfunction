# 1. 役職タグ設定
tag @s add ninja
scoreboard players set @s role_id 2
tag @s add role_assigned

# 2. チャットで通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『忍者』","color":"dark_purple","bold":true},{"text":" です！","color":"white"}]

# 3. インベントリ初期化
clear @s

# 4. 変数初期化
scoreboard players set @s slot_cycle 1
scoreboard players set @s cd_ninja_mark 0
scoreboard players set @s cd_ninja_swap 0
scoreboard players set @s cd_ninja_smoke 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0

# 5. アイテム配布
# 【削除】試合開始時に配るため、ここでは実行しません
# function my_pvp:system/give_ninja_items

# 6. 音
execute at @s run playsound minecraft:entity.illusioner.prepare_mirror master @s ~ ~ ~ 1 1