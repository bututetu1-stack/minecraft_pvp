# 1. スコアボード表示
scoreboard objectives setdisplay sidebar points

# 2. 試合進行
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

# --- 【追加】ポイント計算（常時更新） ---
# ポイント = (キル数 * 10) - (デス数 * 5)
# ※ #POINT_KILL, #POINT_DEATH は setup で設定済み
execute as @a run scoreboard players operation @s points = @s kills
execute as @a run scoreboard players operation @s points *= #POINT_KILL temp
execute as @a run scoreboard players operation @s points -= @s deaths
execute as @a run scoreboard players operation @s points -= @s deaths
execute as @a run scoreboard players operation @s points -= @s deaths
execute as @a run scoreboard players operation @s points -= @s deaths
execute as @a run scoreboard players operation @s points -= @s deaths

# --- 【追加】試合終了判定 ---
# 5分 (6000 tick) 経過したら game_end を実行
execute if score #GLOBAL match_timer matches 6000.. run function my_pvp:system/game_end