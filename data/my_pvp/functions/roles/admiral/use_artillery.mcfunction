# CTチェック
execute if score @s cd_adm_artillery matches 1.. run return 0

# クールダウン設定
scoreboard players set @s cd_adm_artillery 400
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1

# --- レイキャスト開始 ---

# 1. マーカーを「目の位置」に召喚
# (タグから Marker:1b を外すとtp移動が安定することがあるので念のため外しておきます)
summon armor_stand ^ ^1.62 ^0.5 {Tags:["artillery_marker","new_marker"],Invisible:1b,NoGravity:1b}
scoreboard players operation @e[tag=new_marker,limit=1] player_id = @s player_id

# 【重要】プレイヤーの「向き」をマーカーにコピー
# これがないと、常に南へ飛んでいってしまいます
data modify entity @e[tag=new_marker,limit=1] Rotation set from entity @s Rotation

# 2. 視線方向に飛ばす
# (positioned ~ ~-1.62 ~ は削除し、そのままの位置から飛ばします)
execute as @e[tag=new_marker] at @s run function my_pvp:roles/admiral/raycast_loop

# 3. 確定音とメッセージ
execute at @e[tag=new_marker] run playsound minecraft:entity.tnt.primed master @a ~ ~ ~ 1 0.5
execute at @e[tag=new_marker] run particle minecraft:flash ~ ~ ~ 0 0 0 1 10
tellraw @a [{"text":"[警告] ","color":"red"},{"text":"砲撃支援 要請確認! 5秒後に着弾!","color":"yellow"}]

# タグ整理
tag @e[tag=new_marker] remove new_marker