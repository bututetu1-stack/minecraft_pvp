# 1. スコアボード表示
scoreboard objectives setdisplay sidebar points

# 2. 試合進行
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

# --- ポイント計算 ---
execute as @a run scoreboard players operation @s points = @s kills
execute as @a run scoreboard players operation @s points *= #POINT_KILL temp
execute as @a run scoreboard players operation @s temp = @s deaths
execute as @a run scoreboard players operation @s temp *= #POINT_DEATH temp
execute as @a run scoreboard players operation @s points -= @s temp

# --- 【追加】死体処理タグのクリーンアップ ---
# 生きている(HP>0)プレイヤーからは処理済みタグを外す
execute as @a[tag=dead_processing] store result score #HP temp run data get entity @s Health
execute as @a[tag=dead_processing] if score #HP temp matches 1.. run tag @s remove dead_processing

# --- 試合終了判定 ---
execute if score #GLOBAL match_state matches 1 if score #GLOBAL match_timer matches 6000.. run function my_pvp:system/game_end