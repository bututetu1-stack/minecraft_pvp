# --- クールダウン消化 ---
execute if score @s cd_adm_artillery matches 1.. run scoreboard players remove @s cd_adm_artillery 1
execute if score @s cd_adm_torpedo matches 1.. run scoreboard players remove @s cd_adm_torpedo 1
execute if score @s cd_adm_air matches 1.. run scoreboard players remove @s cd_adm_air 1
execute if score @s cd_adm_aa matches 1.. run scoreboard players remove @s cd_adm_aa 1
# 【復活】 陣形変更の連打防止用クールダウン消化
execute if score @s cd_formation matches 1.. run scoreboard players remove @s cd_formation 1

# 役職固有 上昇スキル: 対空射出
execute if score @s cd_adm_jump matches 1.. run scoreboard players remove @s cd_adm_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/admiral/use_jump

# --- CT完了通知 (音) ---
execute if score @s cd_adm_artillery matches 1 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
execute if score @s cd_adm_torpedo matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_adm_air matches 1 run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 0.5
execute if score @s cd_adm_aa matches 1 run playsound minecraft:item.shield.block master @s ~ ~ ~ 1 2
execute if score @s cd_formation matches 1 run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# --- アクションバー (陣形 + 武器CT + 陣形CT) ---
# 0: 単縦陣
execute if score @s adm_formation matches 0 run title @s actionbar [{"text":"[単縦陣] ","color":"red"},{"text":"砲撃: ","color":"gold"},{"score":{"name":"@s","objective":"cd_adm_artillery"},"color":"white"},{"text":" | 魚雷: ","color":"aqua"},{"score":{"name":"@s","objective":"cd_adm_torpedo"},"color":"white"},{"text":" | 航空: ","color":"red"},{"score":{"name":"@s","objective":"cd_adm_air"},"color":"white"},{"text":" | 対空: ","color":"green"},{"score":{"name":"@s","objective":"cd_adm_aa"},"color":"white"},{"text":" | 陣形CT: ","color":"gray"},{"score":{"name":"@s","objective":"cd_formation"},"color":"white"}]

# 1: 輪形陣
execute if score @s adm_formation matches 1 run title @s actionbar [{"text":"[輪形陣] ","color":"green"},{"text":"砲撃: ","color":"gold"},{"score":{"name":"@s","objective":"cd_adm_artillery"},"color":"white"},{"text":" | 魚雷: ","color":"aqua"},{"score":{"name":"@s","objective":"cd_adm_torpedo"},"color":"white"},{"text":" | 航空: ","color":"red"},{"score":{"name":"@s","objective":"cd_adm_air"},"color":"white"},{"text":" | 対空: ","color":"green"},{"score":{"name":"@s","objective":"cd_adm_aa"},"color":"white"},{"text":" | 陣形CT: ","color":"gray"},{"score":{"name":"@s","objective":"cd_formation"},"color":"white"}]

# 2: 警戒陣
execute if score @s adm_formation matches 2 run title @s actionbar [{"text":"[警戒陣] ","color":"aqua"},{"text":"砲撃: ","color":"gold"},{"score":{"name":"@s","objective":"cd_adm_artillery"},"color":"white"},{"text":" | 魚雷: ","color":"aqua"},{"score":{"name":"@s","objective":"cd_adm_torpedo"},"color":"white"},{"text":" | 航空: ","color":"red"},{"score":{"name":"@s","objective":"cd_adm_air"},"color":"white"},{"text":" | 対空: ","color":"green"},{"score":{"name":"@s","objective":"cd_adm_aa"},"color":"white"},{"text":" | 陣形CT: ","color":"gray"},{"score":{"name":"@s","objective":"cd_formation"},"color":"white"}]

# --- スキル発動検知 ---
execute if score @s click_skill matches 1.. run tag @s add using_skill

# 1. 砲撃支援
execute if entity @s[tag=using_skill,nbt={SelectedItem:{components:{"minecraft:custom_data":{adm_artillery:1b}}}}] run function my_pvp:roles/admiral/use_artillery
# 2. 魚雷カットイン
execute if entity @s[tag=using_skill,nbt={SelectedItem:{components:{"minecraft:custom_data":{adm_torpedo:1b}}}}] run function my_pvp:roles/admiral/use_torpedo
# 3. 航空支援
execute if entity @s[tag=using_skill,nbt={SelectedItem:{components:{"minecraft:custom_data":{adm_air:1b}}}}] run function my_pvp:roles/admiral/use_airstrike
# 4. 対空カットイン
execute if entity @s[tag=using_skill,nbt={SelectedItem:{components:{"minecraft:custom_data":{adm_aa:1b}}}}] run function my_pvp:roles/admiral/use_antiair

scoreboard players set @s click_skill 0
tag @s remove using_skill

# --- エンティティ制御 (Tick処理) ---
# --- エンティティ制御 (Tick処理) ---
# game_logic.mcfunction で一括管理するように変更
# execute as @e[tag=artillery_marker] at @s run function my_pvp:roles/admiral/tick_artillery
# execute as @e[tag=adm_torpedo] at @s run function my_pvp:roles/admiral/tick_torpedo
# execute as @e[tag=airstrike_center] at @s run function my_pvp:roles/admiral/process_airstrike
# execute as @e[tag=adm_bomb] at @s run function my_pvp:roles/admiral/tick_bomb

# アイテムスキャン
function my_pvp:roles/admiral/scan_items

# 対空防御
execute as @e[type=area_effect_cloud,tag=aa_center] at @s run function my_pvp:roles/admiral/tick_aa

# --- 陣形システム ---
# 1. 常時効果適用
execute as @s run function my_pvp:roles/admiral/tick_formation

# 【不具合対策】 コマンド/環境ダメージでの反撃発動 (Advancement失敗時の保険)
# 累積値 damage_taken の差分を検出 (新たに被弾したかを edge-trigger で判定)
# 警戒陣 (formation=2) 中、かつ damage_taken が前回値より増加したときのみ発動
execute if score @s adm_formation matches 2 unless score @s last_admiral_damage_taken = @s damage_taken run function my_pvp:roles/admiral/trigger_penalty_v2
# 陣形に関わらず last_admiral_damage_taken を更新 (累積値が増加するまで再発動を防ぐ)
scoreboard players operation @s last_admiral_damage_taken = @s damage_taken

# 2. 右クリック検知 (羅針盤)
execute if score @s click_formation matches 1.. run function my_pvp:roles/admiral/change_formation
scoreboard players set @s click_formation 0

# --- Tick処理完了 ---
# tag @s remove processing_penalty (不要)