# --- クールダウン消化 ---
execute if score @s cd_adm_artillery matches 1.. run scoreboard players remove @s cd_adm_artillery 1
execute if score @s cd_adm_torpedo matches 1.. run scoreboard players remove @s cd_adm_torpedo 1
execute if score @s cd_adm_air matches 1.. run scoreboard players remove @s cd_adm_air 1
execute if score @s cd_adm_aa matches 1.. run scoreboard players remove @s cd_adm_aa 1

# --- CT完了通知 (音) ---
execute if score @s cd_adm_artillery matches 1 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
execute if score @s cd_adm_torpedo matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_adm_air matches 1 run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 0.5
execute if score @s cd_adm_aa matches 1 run playsound minecraft:item.shield.block master @s ~ ~ ~ 1 2

# --- アクションバー ---
title @s actionbar [{"text":"砲撃:","color":"gold"},{"score":{"name":"@s","objective":"cd_adm_artillery"},"color":"white"},{"text":" | 魚雷:","color":"aqua"},{"score":{"name":"@s","objective":"cd_adm_torpedo"},"color":"white"},{"text":" | 航空:","color":"red"},{"score":{"name":"@s","objective":"cd_adm_air"},"color":"white"},{"text":" | 対空:","color":"yellow"},{"score":{"name":"@s","objective":"cd_adm_aa"},"color":"white"}]

# --- スキル発動検知 ---
execute if score @s click_skill matches 1.. run tag @s add using_skill

# 1. 砲撃支援
execute if entity @s[tag=using_skill,nbt={SelectedItem:{tag:{adm_artillery:1b}}}] run function my_pvp:roles/admiral/use_artillery
# 2. 魚雷カットイン
execute if entity @s[tag=using_skill,nbt={SelectedItem:{tag:{adm_torpedo:1b}}}] run function my_pvp:roles/admiral/use_torpedo
# 3. 航空支援
execute if entity @s[tag=using_skill,nbt={SelectedItem:{tag:{adm_air:1b}}}] run function my_pvp:roles/admiral/use_airstrike
# 4. 対空カットイン
execute if entity @s[tag=using_skill,nbt={SelectedItem:{tag:{adm_aa:1b}}}] run function my_pvp:roles/admiral/use_antiair

scoreboard players set @s click_skill 0
tag @s remove using_skill

# --- エンティティ制御 (Tick処理) ---

# 【重要】パスを確認してください。あなたのフォルダ構成と合致していますか？
# 例: data/admiral/functions/tick_artillery.mcfunction なら admiral:tick_artillery です。
execute as @e[tag=artillery_marker] at @s run function my_pvp:roles/admiral/tick_artillery

# 魚雷の移動
execute as @e[tag=adm_torpedo] at @s run function my_pvp:roles/admiral/tick_torpedo

# 航空支援の制御
execute as @e[tag=airstrike_center] at @s run function my_pvp:roles/admiral/process_airstrike
execute as @e[tag=adm_bomb] at @s run function my_pvp:roles/admiral/tick_bomb

# 【追加】アイテムスキャン処理を実行
function my_pvp:roles/admiral/scan_items