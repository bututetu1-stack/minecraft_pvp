# ループ処理 (再帰)
# 距離加算 (1ステップ = 0.5m)
scoreboard players add #RAY_DIST temp 1

# 40ステップ(20m)超えたら終了
execute if score #RAY_DIST temp matches 41.. run return 0

# 0.5m前進してチェック実行
# 前進後の座標で check を呼び出す (check内で再帰呼び出し判定を行う)
execute positioned ^ ^ ^0.5 run function my_pvp:roles/sculptor/raycast/check
