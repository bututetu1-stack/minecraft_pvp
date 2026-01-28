# ヒット時の処理
# @s = sculpture_hitbox
# 実行元プレイヤー = マクロやスコアボードで管理するのは難しいので、エフェクト付与は位置指定で行うか、ID比較を使う

# 自分のIDと比較 (自分の彫刻なら無視)
# 【デバッグ中】一人で確認できるように、自分でも食らうように変更
# execute unless score @s player_id = #TEMP_MY_ID temp run function my_pvp:roles/sculptor/raycast/apply_effect
tellraw @a [{"text":"[DEBUG] Hit!","color":"red"}]
function my_pvp:roles/sculptor/raycast/apply_effect

# ヒットしたのでループ終了フラグを立てる (自分の彫刻だった場合は貫通させる？いや、自分の彫刻も視界を遮るべきか？)
# 仕様: 自分のが邪魔で奥のが見えない、はありうるので、自分のでもヒットしたら終了でOK。
# ただし「自分のには効かない」だけ。
scoreboard players set #RAY_DIST temp 100
