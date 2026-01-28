# 彫刻家レイキャスト - エントリーポイント
# @s = プレイヤー (game_logicから呼び出し)

# 定数セット
scoreboard players set #36000 temp 36000
scoreboard players set #18000 temp 18000

# 自分にタグ付け
tag @s add current_checker

# 周囲20m以内のHitboxに対してチェック
execute at @s as @e[tag=sculpture_hitbox,distance=..20] run function my_pvp:roles/sculptor/checker/check_fov

# タグ削除
tag @s remove current_checker
