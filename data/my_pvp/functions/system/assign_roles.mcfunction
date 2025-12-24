# 1. 初期化
tag @a remove role_assigned
tag @a remove mechanic
tag @a remove ninja
# soldier削除タグを消去

kill @e[tag=role_card]

# 2. 山札の作成
function my_pvp:system/init_role_deck

# 3. 抽選実行
execute as @a[tag=!role_assigned] run function my_pvp:system/distribute_role

# 4. 後片付け
kill @e[tag=role_card]