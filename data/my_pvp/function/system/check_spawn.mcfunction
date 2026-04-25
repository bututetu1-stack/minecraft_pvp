# スポーン地点の有効性チェック (天井 + ワールドボーダー内)
# @s = checking player

# 0. ワールドボーダー外チェック (game_center 基点で 50 以上離れていたら強制再抽選)
tag @s add invalid_spawn
execute if entity @s[tag=invalid_spawn] if entity @e[tag=game_center,distance=..50] run tag @s remove invalid_spawn

# 1. 天井チェック (頭上 2~20ブロックに固体ブロックがあるか？)
# まずは「ボーダー内」だった場合のみ天井チェックを行う
execute unless entity @s[tag=invalid_spawn] run tag @s add invalid_spawn
# 頭上20ブロックぶんの空気を確保する
execute if block ~ ~2 ~ #minecraft:air if block ~ ~3 ~ #minecraft:air if block ~ ~4 ~ #minecraft:air if block ~ ~5 ~ #minecraft:air if block ~ ~6 ~ #minecraft:air if block ~ ~7 ~ #minecraft:air if block ~ ~8 ~ #minecraft:air if block ~ ~9 ~ #minecraft:air if block ~ ~10 ~ #minecraft:air if block ~ ~11 ~ #minecraft:air if block ~ ~12 ~ #minecraft:air if block ~ ~13 ~ #minecraft:air if block ~ ~14 ~ #minecraft:air if block ~ ~15 ~ #minecraft:air if block ~ ~16 ~ #minecraft:air if block ~ ~17 ~ #minecraft:air if block ~ ~18 ~ #minecraft:air if block ~ ~19 ~ #minecraft:air if block ~ ~20 ~ #minecraft:air run tag @s remove invalid_spawn

# 2. 無効な場合 (invalid_spawnあり) はリトライ
# 【修正】game_center 基点で再抽選し、ワールドボーダー内に収める (半径50)
execute if entity @s[tag=invalid_spawn] run scoreboard players add @s retry_count 1
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"スポーン位置を再抽選します...","color":"yellow"}]
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @e[tag=game_center,limit=1] run spreadplayers ~ ~ 10 50 under 45 false @s
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @s run function my_pvp:system/check_spawn

# 3. 諦め (10回失敗) - 中心に強制テレポート
execute if score @s retry_count matches 11.. run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"適正なスポーン地点が見つからなかったため中心に転送します。","color":"red"}]
execute if score @s retry_count matches 11.. at @e[tag=game_center,limit=1] run tp @s ~ ~ ~
tag @s remove invalid_spawn
