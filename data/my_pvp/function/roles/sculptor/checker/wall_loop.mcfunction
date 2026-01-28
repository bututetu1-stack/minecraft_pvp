# 壁チェックループ

# 距離加算
scoreboard players add #RAY_DIST temp 1

# 安全装置 (40ステップ = 20m)
execute if score #RAY_DIST temp matches 41.. run return 0

# 0.5m前進して判定
execute positioned ^ ^ ^0.5 run function my_pvp:roles/sculptor/checker/wall_step
