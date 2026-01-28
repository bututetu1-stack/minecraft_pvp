# 壁チェック開始
# @s = プレイヤー

# 距離カウンターリセット
scoreboard players set #RAY_DIST temp 0

# 視点からターゲットに向かってレイキャスト開始
execute anchored eyes facing entity @e[tag=target_hitbox,limit=1] eyes positioned ^ ^ ^ run function my_pvp:roles/sculptor/checker/wall_loop
