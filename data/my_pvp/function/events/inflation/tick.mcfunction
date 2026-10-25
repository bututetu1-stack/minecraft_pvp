# インフレーションイベント継続処理
# 期間中に増えたキル数 × POINT_KILL を bonus_points に追加する (= キルポイント2倍)

# 途中参加などで記録が無いプレイヤーは現在値から数える
execute as @a unless score @s infl_kills = @s infl_kills run scoreboard players operation @s infl_kills = @s kills

execute as @a unless score @s kills = @s infl_kills run function my_pvp:events/inflation/add_bonus
