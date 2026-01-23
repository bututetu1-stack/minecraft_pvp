# 全プレイヤーが実行
# 1. 定数セット (初回のみで良いが、安全のため毎回確認、あるいは `setup` でやるべきだがここでやる)
scoreboard players set #CONST 36000 36000
scoreboard players set #CONST 18000 18000
scoreboard players set #CONST -1 -1

# 2. 自分にタグ付け
tag @s add current_checker

# 2. 自分にタグ付け
tag @s add current_checker

# デバッグ: メインループ開始 (削除)

# 3. 周囲20m以内のHitboxに対してチェック開始
# デバッグ: Hitboxが見つかったか (削除)

execute at @s as @e[tag=sculpture_hitbox,distance=..20] run function my_pvp:roles/sculptor/checker/check_fov

# 4. タグ削除
tag @s remove current_checker
