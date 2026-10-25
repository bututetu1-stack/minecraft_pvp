# 1. 5秒前のマーカーを探す (自分のIDを持つもの限定)
scoreboard players operation #ID temp = @s player_id
tag @s add reverse_user

# 距離制限内にあり、かつ「自分のID」を持つマーカーを検索
execute at @s as @e[tag=chrono_5s,distance=..60,limit=1,sort=nearest] if score @s player_id = #ID temp run tag @s add my_past_point

# 2. マーカーが見つからない場合 (エラー処理)
# 見つからなかったらエラーメッセージを出して、return 0 で処理をここで打ち切る
# これにより、下のCTセット処理が実行されなくなる
execute unless entity @e[tag=my_past_point] run tellraw @s {"text":"Error: 戻れる過去がありません","color":"red"}
execute unless entity @e[tag=my_past_point] run tag @s remove reverse_user
execute unless entity @e[tag=my_past_point] run return 0

# =================================================
# ▼▼▼ 以下、成功時の処理 ▼▼▼
# =================================================

# 3. CTセット (20秒 = 400tick)
# 成功が確定してからセットする
scoreboard players set @s cd_chrono_reverse 400

# 4. 移動処理
execute as @e[tag=my_past_point] run tp @a[tag=reverse_user] @s

# 5. 回復 & 演出
# マーカーからHPを取得して適応 (マーカーを消す前に読む / 記録が無い場合は HP を変更しない)
execute store result storage my_pvp:macro reverse.hp int 1 run scoreboard players get @e[tag=my_past_point,limit=1] hp_snapshot
execute if score @e[tag=my_past_point,limit=1] hp_snapshot matches 1.. run function my_pvp:roles/chrono/restore_hp with storage my_pvp:macro reverse
kill @e[tag=my_past_point]

# effect give @s minecraft:instant_health 1 1 true
playsound minecraft:item.chorus_fruit.teleport master @a ~ ~ ~ 1 0.5
particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.5 0.5 0.1 50 force
tellraw @s [{"text":"<< Time Reverse (5s)","color":"aqua","bold":true}]

# 6. タグ掃除
tag @s remove reverse_user