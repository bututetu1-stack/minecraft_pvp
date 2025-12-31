# --- 1. 位置調整 ---
# 空中にいる場合は地面に落とす
execute if entity @s[tag=bomb_falling] if block ~ ~-0.1 ~ minecraft:air run tp @s ~ ~-1 ~
execute if entity @s[tag=bomb_falling] unless block ~ ~-0.1 ~ minecraft:air run tag @s remove bomb_falling

# --- 2. 予兆パーティクル ---
# 彗星 (赤)
execute if entity @s[tag=type_suisei] run particle minecraft:dust 1 0 0 1.5 ~ ~0.2 ~ 0.5 0 0.5 0 5 force
execute if entity @s[tag=type_suisei] run particle minecraft:falling_dust red_concrete ~ ~5 ~ 0.1 2 0.1 0 1 force

# 烈風 (緑)
execute if entity @s[tag=type_reppu] run particle minecraft:dust 0 1 0 1.5 ~ ~0.2 ~ 0.5 0 0.5 0 5 force
execute if entity @s[tag=type_reppu] run particle minecraft:falling_dust lime_concrete ~ ~5 ~ 0.1 2 0.1 0 1 force

# 流星 (青)
execute if entity @s[tag=type_ryusei] run particle minecraft:dust 0 0 1 2 ~ ~0.2 ~ 1 0 1 0 10 force
execute if entity @s[tag=type_ryusei] run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute if entity @s[tag=type_ryusei] run particle minecraft:falling_dust blue_concrete ~ ~5 ~ 0.1 2 0.1 0 2 force

# 音 (落下音演出)
execute if score @s temp matches 20 run playsound minecraft:entity.phantom.flap master @a[distance=..10] ~ ~ ~ 1 2
execute if score @s temp matches 10 run playsound minecraft:entity.firework_rocket.launch master @a[distance=..10] ~ ~ ~ 1 0.5

# --- 3. カウントダウン & 起爆 ---
scoreboard players remove @s temp 1
execute if score @s temp matches ..0 run function my_pvp:roles/admiral/process_bomb_explode