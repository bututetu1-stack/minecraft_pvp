# 1秒(20tick)ごとに座標を記録・更新する

# タイマー加算
scoreboard players add @s timer 1

# 20tick経過したら更新処理
execute if score @s timer matches 20.. run function my_pvp:roles/chrono/record_position_update
execute if score @s timer matches 20.. run scoreboard players set @s timer 0