# --- パーティクルの描画 (ローカル座標 ^ ^ ^ を使用) ---

# 円形にパーティクルを表示 (水色)
# 1. 中心リング (赤道, 半径10m)
execute positioned ^ ^0 ^10 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force

# 2. 上段リング (半径约8.6m, 高さ5m)
execute positioned ^ ^5 ^8.6 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force

# 3. 最上段リング (半径约5m, 高さ8.6m)
execute positioned ^ ^8.6 ^5 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force

# 4. 下段リング (半径约8.6m, 高さ-5m)
execute positioned ^ ^-5 ^8.6 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force

# 5. 最下段リング (半径约5m, 高さ-8.6m)
execute positioned ^ ^-8.6 ^5 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force


# --- ループ処理 ---
# カウンタを進める
scoreboard players add #DOME_LOOP temp 1

# 36回 (36 * 10度 = 360度) 繰り返す
execute if score #DOME_LOOP temp matches ..35 rotated ~10 ~0 run function my_pvp:roles/chrono/draw_dome_loop