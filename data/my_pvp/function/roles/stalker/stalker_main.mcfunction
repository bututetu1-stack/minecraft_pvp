# 1. コンパスの更新
tag @a remove my_target
scoreboard players operation #TEMP player_id = @s target_id
execute as @a[gamemode=!spectator] if score @s player_id = #TEMP player_id run tag @s add my_target

execute if entity @a[tag=my_target] run function my_pvp:roles/stalker/update_compass

# --- 0. 攻撃力無効化 (Weakness 255) ---
# マクロ攻撃システムのため、物理攻撃力を0にする
effect give @s minecraft:weakness 2 255 true

# --- 追加機能: ターゲット追跡 ---
# 1. ターゲットに足跡を残させる
execute as @a[tag=my_target] at @s run function my_pvp:roles/stalker/leave_trail

# 2. 足跡を表示 (自分にだけ見えるように)
# 準備: ターゲットIDをTEMPに格納 & 自分にタグ付け
scoreboard players operation #TEMP player_id = @s target_id
tag @s add current_stalker
# 全トレイルを処理
execute as @e[tag=stalker_trail] run function my_pvp:roles/stalker/trail_tick
tag @s remove current_stalker

# 3. 視線デバフ (Raycast)
# 距離20m (0.5 * 40)
scoreboard players set #ray_dist temp 40
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/stalker/raycast

# 2. ターゲット生存確認 & 再抽選
execute unless entity @a[tag=my_target] run scoreboard players add @s target_check_timer 1
execute if score @s target_check_timer matches 20.. run function my_pvp:roles/stalker/assign_target
execute if score @s target_check_timer matches 20.. run scoreboard players set @s target_check_timer 0

# 3. 攻撃判定 (追加ダメージ)
execute unless score @s last_damage_dealt = @s damage_dealt run function my_pvp:roles/stalker/check_attack
execute unless score @s last_damage_dealt = @s damage_dealt run scoreboard players operation @s last_damage_dealt = @s damage_dealt

# 4. アイテム補充
function my_pvp:roles/stalker/scan_items

# 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump

# --- 【新能力】 ハンターズトランス: ターゲット撃破時の強化 ---
# ターゲットID保持中に、自身のkillsが増えていれば撃破成功
execute unless score @s last_kills = @s kills run effect give @s minecraft:strength 6 0 true
execute unless score @s last_kills = @s kills run effect give @s minecraft:speed 6 1 true
execute unless score @s last_kills = @s kills run effect give @s minecraft:instant_health 1 4 true
execute unless score @s last_kills = @s kills run playsound minecraft:entity.wither.spawn master @s ~ ~ ~ 0.6 1.5
execute unless score @s last_kills = @s kills run tellraw @s [{"text":"[ハンターズトランス] ","color":"dark_red","bold":true},{"text":"獲物を喰らった","color":"red"}]
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# 5. UI表示 (クールダウン表示)
title @s actionbar [{"text":"Float: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_stalker_float"},"color":"white"}]

# 6. スキル制御
# 狂愛の飛翔 (Mad Love)
function my_pvp:roles/stalker/ghost_float

# クールダウンの消化 & 通知
execute if score @s cd_stalker_float matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_stalker_float matches 1.. run scoreboard players remove @s cd_stalker_float 1