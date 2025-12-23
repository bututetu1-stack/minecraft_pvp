# 1. スコアボードをサイドバーに表示（デバッグ用）
scoreboard objectives setdisplay sidebar points

# 2. 試合状態が「1（試合中）」の時だけ、ゲームのメインロジックを実行
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic

# 試合中(match_state=1)なら、タイマーを毎チック 1 ずつ増やす（超重要！）
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1