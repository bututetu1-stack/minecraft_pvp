# 壁チェック開始
# @s = player
# ターゲット(@e[tag=target_hitbox])に向かってレイキャスト

# 距離カウンターリセット
scoreboard players set #RAY_DIST temp 0

# デバッグ
# tellraw @s [{"text":"[DEBUG] FOV OK -> Wall Check","color":"aqua"}]

# 視点からスタートし、ターゲットに向かって進む
execute anchored eyes facing entity @e[tag=target_hitbox,limit=1] feet positioned ^ ^ ^ run function my_pvp:roles/sculptor/checker/wall_loop
