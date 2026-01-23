# ルーレットの進行処理 (game_logic から実行)
# @s = marker (roulette_marker)

# パーティクル演出
particle minecraft:witch ~ ~1 ~ 0.5 0.5 0.5 0.1 5

# タイマー減算
scoreboard players remove @s roulette_timer 1

# 判定 (0になったら)
execute if score @s roulette_timer matches 0 run function my_pvp:roles/gambler/skills/roulette_result

# 終了処理 (結果処理内で kill @s する)
