# 0.5ブロックずつ前進
tp @s ^ ^ ^0.5

# 距離制限 (60回 = 30ブロック)
scoreboard players add @s temp 1
# 距離制限に達したら停止 (この場合 hit_block はつかない)
execute if score @s temp matches 60.. run tag @s add ray_stop

# ブロック衝突判定
# ブロックに当たったら「hit_block」と「ray_stop」を付ける
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:water unless block ~ ~ ~ minecraft:grass run tag @s add hit_block
execute if entity @s[tag=hit_block] run tag @s add ray_stop

# まだ停止フラグがなければ再帰呼び出し
execute as @s[tag=!ray_stop] at @s run function my_pvp:roles/admiral/raycast_loop

# ループ終了時: ブロックに当たっていればカウントダウン開始 (temp=100)
execute if entity @s[tag=ray_stop,tag=hit_block] run scoreboard players set @s temp 100