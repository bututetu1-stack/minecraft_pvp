# 1. スコアボード表示
scoreboard objectives setdisplay sidebar points

# 2. 試合進行
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

# --- ポイント計算（常時更新） ---
# ポイント = (キル数 * 10) - (デス数 * 5)
execute as @a run scoreboard players operation @s points = @s kills
execute as @a run scoreboard players operation @s points *= #POINT_KILL temp
execute as @a run scoreboard players operation @s temp = @s deaths
execute as @a run scoreboard players operation @s temp *= #POINT_DEATH temp
execute as @a run scoreboard players operation @s points -= @s temp

# --- 【修正】試合終了判定 ---
# 「試合中(state=1) かつ 時間経過(6000以上)」の場合のみ実行するように修正
# これで試合終了後(state=2)に無限ループしなくなります
execute if score #GLOBAL match_state matches 1 if score #GLOBAL match_timer matches 6000.. run function my_pvp:system/game_end