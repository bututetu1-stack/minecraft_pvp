# 1. 試合進行（game_logicを呼び出す）
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic
