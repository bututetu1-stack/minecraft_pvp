# インフレーションイベント開始

# キルポイントを2倍にする
# ※ ポイントは毎tick「kills × POINT_KILL」で再計算されるため、POINT_KILL を変えると過去のキルまで2倍になり
#    終了時に元に戻ってしまう。開始時のキル数を記録し、期間中に増えた分だけ bonus_points に加算する (inflation/tick)
execute as @a run scoreboard players operation @s infl_kills = @s kills

# 告知
title @a title [{"text":"【インフレーション】","color":"gold","bold":true}]
title @a subtitle [{"text":"キルポイント2倍！","color":"yellow"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"インフレーション発生！","color":"red","bold":true},{"text":" - キル時のポイントが2倍になります！","color":"white"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 1 1
