# 業火爆裂 投射体tick (@s = mag_inferno marker, at @s)

# --- 1. 視認性パーティクル ---
execute as @s at @s run particle minecraft:flame ^ ^ ^-0.5 0.2 0.2 0.2 0.03 4
execute as @s at @s run particle minecraft:large_smoke ^ ^ ^-0.5 0.1 0.1 0.1 0.01 2
execute as @s at @s run particle minecraft:lava ~ ~ ~ 0 0 0 0 1
execute as @s at @s run particle minecraft:dust{color:[1.0,0.4,0.0],scale:1.2} ~ ~ ~ 0.2 0.2 0.2 0 3

# --- 2. 凍結チェック ---
execute if entity @s[tag=is_frozen] run return 0

# --- 3. 寿命カウント ---
scoreboard players add @s gadget_life 1

# --- 4. 移動 (1.5 blocks/tick = 30 m/s) ---
execute as @s at @s run tp @s ^ ^ ^1.5

# --- 5. 命中判定 (半径2m の他プレイヤー) ---
scoreboard players operation #INF_OWNER temp = @s player_id
tag @a remove inf_target_temp
execute at @s as @a[distance=..2,gamemode=!spectator] unless score @s player_id = #INF_OWNER temp run tag @s add inf_target_temp
execute if entity @a[tag=inf_target_temp] run tag @s add inferno_should_explode
tag @a remove inf_target_temp

# --- 6. ブロック衝突判定 ---
execute as @s at @s unless block ~ ~ ~ air unless block ~ ~ ~ cave_air run tag @s add inferno_should_explode

# --- 7. 着弾爆発 ---
execute if entity @s[tag=inferno_should_explode] at @s run function my_pvp:roles/magician/inferno_explode
execute if entity @s[tag=inferno_should_explode] run kill @s

# --- 8. 寿命切れで不発消滅 ---
execute if score @s gadget_life matches 50.. run kill @s
