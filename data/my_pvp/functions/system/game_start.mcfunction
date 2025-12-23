# 全プレイヤーにまだIDがなければ、#NEXT_IDの値を割り振る
execute as @a[scores={player_id=0}] run scoreboard players operation @s player_id = #NEXT_ID player_id
# 次の人のためにIDカウンターを1増やす
scoreboard players add #NEXT_ID player_id 1