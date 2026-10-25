# スポーン地点の有効性チェック (緩和版)
# @s = checking player

# 0. ワールドボーダー外チェック (game_center 基点で 50 以上離れていたら強制再抽選)
tag @s add invalid_spawn
execute if entity @s[tag=invalid_spawn] if entity @e[tag=game_center,distance=..50] run tag @s remove invalid_spawn

# 1. 頭上チェック (緩和: 必要なのは頭上 ~2~3 の 2ブロックの空気だけ)
# 厳密にチェックすると殆どの地点で失敗してしまうため、最低限の頭上空間のみ確認
execute unless entity @s[tag=invalid_spawn] run tag @s add invalid_spawn
execute if block ~ ~2 ~ #minecraft:air if block ~ ~3 ~ #minecraft:air run tag @s remove invalid_spawn

# 2. 無効な場合はリトライ (game_center 基点で再抽選、半径50)
execute if entity @s[tag=invalid_spawn] run scoreboard players add @s retry_count 1
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @e[tag=game_center,limit=1] run spreadplayers ~ ~ 10 50 under 45 false @s
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @s run function my_pvp:system/check_spawn

# 3. 諦め (10回失敗) - 通知のみ、転送はせずに最終位置を採用
execute if score @s retry_count matches 11.. run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"スポーン地点抽選を打ち切ります。","color":"gray"}]
tag @s remove invalid_spawn
