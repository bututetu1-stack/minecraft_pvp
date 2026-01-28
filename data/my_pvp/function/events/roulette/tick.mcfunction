# --- ルーレット処理 (State Machine) ---

# State 1: Stopped (Linger Phase)
# 静止表示を維持
execute if score #ROULETTE_STATE temp matches 1 as @e[tag=roulette_part] run function my_pvp:events/roulette/update_parts
execute if score #ROULETTE_STATE temp matches 1 run return 0

# State 0: Spinning
# 回転処理
execute as @e[tag=roulette_center] at @s run function my_pvp:events/roulette/tick_internal
# 部品更新
execute as @e[tag=roulette_part] run function my_pvp:events/roulette/update_parts

# 終了判定 (Duration == 1 かつ State 0 の時だけ Result を呼ぶ)
execute if score #GLOBAL event_duration matches 1 as @e[tag=roulette_center] at @s run function my_pvp:events/roulette/result
