# インフレ期間中に増えたキルのボーナス加算
# @s = player
scoreboard players operation #INFL_DIFF temp = @s kills
scoreboard players operation #INFL_DIFF temp -= @s infl_kills
scoreboard players operation #INFL_DIFF temp *= #POINT_KILL temp
scoreboard players operation @s bonus_points += #INFL_DIFF temp
scoreboard players operation @s infl_kills = @s kills
