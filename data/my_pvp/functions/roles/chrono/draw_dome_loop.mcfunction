# --- パーティクルの描画 (ローカル座標 ^ ^ ^ を使用) ---

# 1. 下段リング (半径20m)
particle minecraft:dust_color_transition 0.0 1.0 1.0 2.0 0.0 0.0 1.0 ^ ^0.5 ^20 0 0 0 0 1 force

# 2. 中段リング (半径約17m)
particle minecraft:dust_color_transition 0.0 0.8 1.0 2.0 0.0 0.0 1.0 ^ ^10 ^17.3 0 0 0 0 1 force

# 3. 上段リング (半径約10m)
particle minecraft:dust_color_transition 0.0 0.5 1.0 2.0 0.0 0.0 1.0 ^ ^17 ^10.5 0 0 0 0 1 force


# --- ループ処理 ---
# カウンタを進める
scoreboard players add #DOME_LOOP temp 1

# 36回 (36 * 10度 = 360度) 繰り返す
# rotated ~10 ~ で、現在の向きからさらに10度回転させて自分を呼び出す
execute if score #DOME_LOOP temp matches ..35 positioned ~ ~ ~ rotated ~10 ~ run function my_pvp:roles/chrono/draw_dome_loop