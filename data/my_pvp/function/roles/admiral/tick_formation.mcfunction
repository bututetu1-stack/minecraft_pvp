# === 凍結チェック ===
execute if entity @s[tag=is_frozen] run return 0

# === 0: 単縦陣 (Line Ahead) ===
execute if score @s adm_formation matches 0 run effect give @s minecraft:strength 1 0 true

# === 1: 輪形陣 (Diamond) ===
execute if score @s adm_formation matches 1 run effect give @s minecraft:resistance 1 0 true
execute if score @s adm_formation matches 1 run effect give @s minecraft:weakness 1 0 true

# === 2: 警戒陣 (Cruising) ===
execute if score @s adm_formation matches 2 run effect give @s minecraft:speed 1 1 true
execute if score @s adm_formation matches 2 run effect give @s minecraft:weakness 1 1 true


# --- CT消化 (admiral_mainで管理するため削除)
# scoreboard players remove @s[scores={cd_formation=1..}] cd_formation 1