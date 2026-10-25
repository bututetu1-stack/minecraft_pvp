# スポーン地点の有効性チェック (天井があるか確認)
# @s = checking player

# 1. 天井チェック (頭上 2~15ブロックに固体ブロックがあるか？)
# タグ #my_pvp:air (minecraft:air, minecraft:void_air, etc) 以外があれば「屋内」とみなす
# 簡易的に空気を指定して unless で判定

tag @s add invalid_spawn
# 頭上20ブロックぶんの空気を確保する
execute if block ~ ~2 ~ #minecraft:air if block ~ ~3 ~ #minecraft:air if block ~ ~4 ~ #minecraft:air if block ~ ~5 ~ #minecraft:air if block ~ ~6 ~ #minecraft:air if block ~ ~7 ~ #minecraft:air if block ~ ~8 ~ #minecraft:air if block ~ ~9 ~ #minecraft:air if block ~ ~10 ~ #minecraft:air if block ~ ~11 ~ #minecraft:air if block ~ ~12 ~ #minecraft:air if block ~ ~13 ~ #minecraft:air if block ~ ~14 ~ #minecraft:air if block ~ ~15 ~ #minecraft:air if block ~ ~16 ~ #minecraft:air if block ~ ~17 ~ #minecraft:air if block ~ ~18 ~ #minecraft:air if block ~ ~19 ~ #minecraft:air if block ~ ~20 ~ #minecraft:air run tag @s remove invalid_spawn

# 2. 無効な場合 (invalid_spawnあり) はリトライ
execute if entity @s[tag=invalid_spawn] run scoreboard players add @s retry_count 1
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"構造物内を検知しました。リスポーン位置を再抽選します...","color":"yellow"}]
# random_spawn と同じく game_center を中心に半径50で再抽選 (ワールドボーダーは半径60)
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @e[tag=game_center,limit=1] run spreadplayers ~ ~ 10 50 under 45 false @s
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @s run function my_pvp:system/check_spawn

# 3. 諦め (10回失敗) または 成功
# 失敗しすぎた場合は警告を出しつつ、そのまま許可する（無限ループ防止） or 最悪のケースとしてY制限なしで飛ぶ？
# ここでは「仕方なく許可」とする
execute if score @s retry_count matches 11.. run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"適正なスポーン地点が見つかりませんでした。","color":"red"}]
tag @s remove invalid_spawn
