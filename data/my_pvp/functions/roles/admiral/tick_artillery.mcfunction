# カウントダウン
scoreboard players remove @s temp 1

# --- 警告エフェクト (5秒間出し続ける) ---
# 円形に炎や煙を出す (簡易的な赤パーティクル)
particle minecraft:dust 1 0 0 2 ~ ~1 ~ 5 0 5 0 10 force
particle minecraft:flame ~ ~1 ~ 2 0 2 0.05 5 force

# 音 (秒針のような音)
execute if score @s temp matches 80 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1
execute if score @s temp matches 60 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1
execute if score @s temp matches 40 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1
execute if score @s temp matches 20 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 2

# --- 着弾 (カウント0) ---
execute if score @s temp matches ..0 run function my_pvp:roles/admiral/process_explosion