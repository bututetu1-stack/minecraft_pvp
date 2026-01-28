# --- パーティクルの描画 (ローカル座標 ^ ^ ^ を使用) ---

# 円形にパーティクルを表示 (水色)
# 色指定を [0.0, 1.0, 1.0] (3つだけ) に修正
# 1. 下段リング (半径20m)
execute positioned ^ ^0.5 ^20 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force

# 2. 中段リング (半径約17m)
execute positioned ^ ^10 ^17.3 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force

# 3. 上段リング (半径約10m)
execute positioned ^ ^17 ^10.5 run particle minecraft:dust{color:[0.0,1.0,1.0],scale:2.0} ~ ~ ~ 0 0 0 0 1 force


# --- ループ処理 ---
# カウンタを進める
scoreboard players add #DOME_LOOP temp 1

# 36回 (36 * 10度 = 360度) 繰り返す
execute if score #DOME_LOOP temp matches ..35 rotated ~10 ~0 run function my_pvp:roles/chrono/draw_dome_loop