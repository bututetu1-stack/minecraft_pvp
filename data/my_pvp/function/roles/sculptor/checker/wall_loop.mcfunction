# 壁チェックループ
# 距離加算 (1ステップ = 0.5m)
scoreboard players add #RAY_DIST temp 1

# 40ステップ(20m)超えたら終了 (安全装置)
execute if score #RAY_DIST temp matches 41.. run return 0

# 0.5m前進
execute positioned ^ ^ ^0.5 run function my_pvp:roles/sculptor/checker/wall_step
