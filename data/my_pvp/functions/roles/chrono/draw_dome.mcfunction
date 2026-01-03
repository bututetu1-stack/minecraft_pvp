# ループ用カウンタをリセット
scoreboard players set #DOME_LOOP temp 0

# 回転を0にリセットした状態でループ関数を開始
execute rotated 0 0 run function my_pvp:roles/chrono/draw_dome_loop