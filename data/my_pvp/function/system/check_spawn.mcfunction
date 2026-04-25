# スポーン地点の有効性チェック
# 1. 頭上の障害物 (天井) チェック
# 2. 足元の地面 (空中スポーン防止) チェック
# 3. ステージ外チェック (game_centerから半径60以内)

tag @s add invalid_spawn

# --- 1. 頭上空気チェック (~2 ~ ~20の間に空気が連続) ---
execute if block ~ ~2 ~ #minecraft:air if block ~ ~3 ~ #minecraft:air if block ~ ~4 ~ #minecraft:air if block ~ ~5 ~ #minecraft:air if block ~ ~6 ~ #minecraft:air if block ~ ~7 ~ #minecraft:air if block ~ ~8 ~ #minecraft:air if block ~ ~9 ~ #minecraft:air if block ~ ~10 ~ #minecraft:air if block ~ ~11 ~ #minecraft:air if block ~ ~12 ~ #minecraft:air if block ~ ~13 ~ #minecraft:air if block ~ ~14 ~ #minecraft:air if block ~ ~15 ~ #minecraft:air if block ~ ~16 ~ #minecraft:air if block ~ ~17 ~ #minecraft:air if block ~ ~18 ~ #minecraft:air if block ~ ~19 ~ #minecraft:air if block ~ ~20 ~ #minecraft:air run tag @s add ceiling_ok

# --- 2. 足元の地面チェック (~-1 が固体) ---
# 地面が空気/液体ではないことを確認
execute unless block ~ ~-1 ~ #minecraft:air unless block ~ ~-1 ~ minecraft:water unless block ~ ~-1 ~ minecraft:lava unless block ~ ~-1 ~ minecraft:cave_air unless block ~ ~-1 ~ minecraft:void_air run tag @s add ground_ok

# --- 3. ステージ内チェック (game_centerから水平距離60以内) ---
execute if entity @e[tag=game_center,distance=..60,limit=1] run tag @s add inside_stage

# --- 全条件OKなら invalid_spawn 解除 ---
execute if entity @s[tag=ceiling_ok,tag=ground_ok,tag=inside_stage] run tag @s remove invalid_spawn

# 一時タグ掃除
tag @s remove ceiling_ok
tag @s remove ground_ok
tag @s remove inside_stage

# --- リトライ判定 ---
execute if entity @s[tag=invalid_spawn] run scoreboard players add @s retry_count 1

# 10回まではspreadplayersでリトライ
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @e[tag=game_center,limit=1] run spreadplayers ~ ~ 10 50 under 45 false @s
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches ..10 at @s run function my_pvp:system/check_spawn

# --- 諦めたらフォールバック: game_center に転送 ---
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches 11.. at @e[tag=game_center,limit=1] run tp @s ~ ~ ~
execute if entity @s[tag=invalid_spawn] if score @s retry_count matches 11.. run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"安全なスポーン地点が見つからなかったため、中央へ転送しました","color":"yellow"}]

tag @s remove invalid_spawn
