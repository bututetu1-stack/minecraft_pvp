# ループ用カウンタをリセット
scoreboard players set #DOME_LOOP temp 0

# 回転を0にリセットし、位置を@sに固定した状態でループ関数を開始
# positioned as @s を入れることで、呼び出し元の位置ズレを防ぐ
execute positioned as @s rotated 0 0 run function my_pvp:roles/chrono/draw_dome_loop