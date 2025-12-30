# 0.5ブロックずつ前進
tp @s ^ ^ ^0.5

# 距離制限 (60回 = 30ブロック)
scoreboard players add @s temp 1
execute if score @s temp matches 60.. run tag @s add ray_stop

# ブロック衝突判定
# 空気・水・草以外ならヒット扱い
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:water unless block ~ ~ ~ minecraft:grass run tag @s add hit_block
execute if entity @s[tag=hit_block] run tag @s add ray_stop

# まだ停止フラグがなければ再帰呼び出し
execute as @s[tag=!ray_stop] at @s run function my_pvp:roles/admiral/raycast_loop

# ループ終了
# 【重要】ここでは時間をセットしません (use_artillery側でガチャをして決めます)