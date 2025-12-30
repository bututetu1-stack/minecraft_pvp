# 0.5ブロックずつ前進
tp @s ^ ^ ^0.5

# 距離制限 (修正: 60回 = 30ブロック)
# 200.. だったのを 60.. に変更
scoreboard players add @s temp 1
execute if score @s temp matches 60.. run tag @s add ray_stop

# ブロックに埋まったら停止
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:water unless block ~ ~ ~ minecraft:grass run tag @s add ray_stop

# まだ停止フラグがなければ再帰呼び出し
execute as @s[tag=!ray_stop] at @s run function my_pvp:roles/admiral/raycast_loop

# ループが終わったら temp をリセットして、カウントダウン用スコアをセット
execute if entity @s[tag=ray_stop] run scoreboard players set @s temp 100