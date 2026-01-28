# 1. コンパスの更新
tag @a remove my_target
scoreboard players operation #TEMP player_id = @s target_id
execute as @a[gamemode=!spectator] if score @s player_id = #TEMP player_id run tag @s add my_target

execute if entity @a[tag=my_target] run function my_pvp:roles/stalker/update_compass

# 2. ターゲット生存確認 & 再抽選
execute unless entity @a[tag=my_target] run scoreboard players add @s target_check_timer 1
execute if score @s target_check_timer matches 20.. run function my_pvp:roles/stalker/assign_target
execute if score @s target_check_timer matches 20.. run scoreboard players set @s target_check_timer 0

# 3. 攻撃判定 (追加ダメージ)
execute unless score @s last_damage_dealt = @s damage_dealt run function my_pvp:roles/stalker/check_attack
execute unless score @s last_damage_dealt = @s damage_dealt run scoreboard players operation @s last_damage_dealt = @s damage_dealt

# 4. アイテム補充
function my_pvp:roles/stalker/scan_items

# 5. UI表示 (クールダウン表示)
title @s actionbar [{"text":"Float: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_stalker_float"},"color":"white"}]

# 6. スキル制御
# 狂愛の飛翔 (Mad Love)
function my_pvp:roles/stalker/ghost_float

# クールダウンの消化 & 通知
execute if score @s cd_stalker_float matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_stalker_float matches 1.. run scoreboard players remove @s cd_stalker_float 1