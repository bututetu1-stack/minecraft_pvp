# CTチェック
execute if score @s cd_adm_artillery matches 1.. run return 0

# 仮でクールダウンを設定
scoreboard players set @s cd_adm_artillery 400
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1

# --- レイキャスト開始 ---
summon armor_stand ^ ^1.62 ^0.5 {Tags:["artillery_marker","new_marker"],Invisible:1b,NoGravity:1b}
scoreboard players operation @e[tag=new_marker,limit=1] player_id = @s player_id
data modify entity @e[tag=new_marker,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=new_marker] at @s run function my_pvp:roles/admiral/raycast_loop

# --- 結果判定 ---

# A. 失敗時
execute unless entity @e[tag=new_marker,tag=hit_block] run tellraw @s [{"text":"射程外です！地面や壁を狙ってください","color":"red"}]
execute unless entity @e[tag=new_marker,tag=hit_block] run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute unless entity @e[tag=new_marker,tag=hit_block] run scoreboard players set @s cd_adm_artillery 0
execute unless entity @e[tag=new_marker,tag=hit_block] run kill @e[tag=new_marker]

# B. 成功時
# 1. 音と演出
execute if entity @e[tag=new_marker,tag=hit_block] at @e[tag=new_marker] run playsound minecraft:entity.tnt.primed master @a[distance=..20] ~ ~ ~ 1 0.5
execute if entity @e[tag=new_marker,tag=hit_block] at @e[tag=new_marker] run particle minecraft:flash ~ ~ ~ 0 0 0 1 10

# 2. 範囲警告 (敵/味方問わず近くにいる人へ)
execute if entity @e[tag=new_marker,tag=hit_block] at @e[tag=new_marker] run tellraw @a[distance=..10] [{"text":"[警告] ","color":"red"},{"text":"あなたの現在地に","color":"yellow"},{"text":" 砲撃支援 ","color":"gold","bold":true},{"text":"が要請されました！退避してください！","color":"yellow"}]

# 3. 【追加】自分への成功メッセージ
execute if entity @e[tag=new_marker,tag=hit_block] run tellraw @s [{"text":"[提督] ","color":"gray"},{"text":"砲撃支援を要請しました！5秒後に着弾します！","color":"gold"}]

# タグ整理
tag @e[tag=new_marker] remove new_marker