# レイキャスト開始 (全プレイヤー実行)
# 0. タグ付与
tag @s add current_raycaster

# 1. 自分のIDを保持
scoreboard players operation #TEMP_MY_ID temp = @s player_id

# 2. 距離カウンターリセット
scoreboard players set #RAY_DIST temp 0

# 3. 視点位置(eyes)でループ開始
# tellraw @a [{"text":"[DEBUG] RC Start","color":"green"}]
execute anchored eyes positioned ^ ^ ^ run function my_pvp:roles/sculptor/raycast/loop

# 4. タグ削除
tag @s remove current_raycaster
