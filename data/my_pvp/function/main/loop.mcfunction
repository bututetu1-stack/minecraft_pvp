# 1. 試合進行（game_logicを呼び出す）
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic

# --- 死体処理タグのクリーンアップ ---
# 生きている(HP>0)プレイヤーからは処理済みタグを外す
execute as @a[tag=dead_processing] store result score #HP temp run data get entity @s Health
execute as @a[tag=dead_processing] if score #HP temp matches 1.. run tag @s remove dead_processing