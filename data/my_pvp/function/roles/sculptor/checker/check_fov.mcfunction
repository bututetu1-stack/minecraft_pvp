# 視野角判定
# @s = sculpture_hitbox

# ターゲットにタグ付け
# 【追加】自分の彫刻なら無視
scoreboard players operation #TEMPID temp = @s player_id
execute as @a[tag=current_checker] if score @s player_id = #TEMPID temp run return 0

tag @s add target_hitbox

# プレイヤーとして角度計算を実行
execute as @a[tag=current_checker,limit=1] run function my_pvp:roles/sculptor/checker/calc_angle

# タグ削除
tag @s remove target_hitbox
