# --- 速度計算 (Speed Calculation) ---
# 残り時間(event_duration) に比例して速度を下げる
# Linear Deceleration: Speed = Duration / 10
# Example: 400 -> 40, 100 -> 10, 10 -> 1

scoreboard players operation @s roulette_timer = #GLOBAL event_duration
scoreboard players set #CONST_10 temp 10
scoreboard players operation @s roulette_timer /= #CONST_10 temp

# 最低速度1を保証
execute if score @s roulette_timer matches ..0 run scoreboard players set @s roulette_timer 1


# --- 回転処理 (Rotation) ---
# 現在の回転角を取得
execute store result score #CUR_ROT temp run data get entity @s Rotation[0]

# 回転適用 (Macro)
execute store result storage my_pvp:macro speed int 1 run scoreboard players get @s roulette_timer
function my_pvp:events/roulette/spin_macro with storage my_pvp:macro

# --- サウンド処理 (Sound Logic) ---
# 回転によってセクター(30度区切り)をまたいだか判定
execute store result score #NEW_ROT temp run data get entity @s Rotation[0]

# 正規化 (0-360)
scoreboard players add #CUR_ROT temp 360
scoreboard players set #CONST_360 temp 360
scoreboard players operation #CUR_ROT temp %= #CONST_360 temp

scoreboard players add #NEW_ROT temp 360
scoreboard players operation #NEW_ROT temp %= #CONST_360 temp

# セクターID (0-11)
scoreboard players set #CONST_30 temp 30
scoreboard players operation #CUR_ROT temp /= #CONST_30 temp
scoreboard players operation #NEW_ROT temp /= #CONST_30 temp

# セクターが変わっていたら音を鳴らす (全員に聞こえるように)
execute unless score #CUR_ROT temp = #NEW_ROT temp as @a at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 0.5 2.0
execute unless score #CUR_ROT temp = #NEW_ROT temp as @a at @s run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.5 1.0

# --- 描画 (Entity Update is handled in tick.mcfunction) ---
# function my_pvp:events/roulette/draw
