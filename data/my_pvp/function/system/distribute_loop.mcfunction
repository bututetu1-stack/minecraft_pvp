# 役職が決まっていないプレイヤーをランダムに1人選ぶ
tag @a remove target_candidate
tag @a[tag=!role_assigned,limit=1,sort=random] add target_candidate

# 対象がいなければループ終了
execute unless entity @a[tag=target_candidate] run return 0

# 選ばれた人が役職カードを引く
execute as @a[tag=target_candidate] run function my_pvp:system/distribute_role

# ループ継続（まだ決まってない人がいれば再実行）
execute if entity @a[tag=!role_assigned] run function my_pvp:system/distribute_loop