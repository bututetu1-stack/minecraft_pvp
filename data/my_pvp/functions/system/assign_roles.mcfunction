# 1. 初期化
# 全員から役職タグを消す
tag @a remove role_assigned
tag @a remove mechanic
tag @a remove soldier

# 古い山札が残っていたら消す
kill @e[tag=role_card]

# 2. 山札の作成（くじを生成）
function my_pvp:system/init_role_deck

# 3. 抽選実行
# 役職が決まっていないプレイヤー全員に対して、くじを引かせる
execute as @a[tag=!role_assigned] run function my_pvp:system/distribute_role

# 4. 後片付け
# 余ったくじ（山札）を消去
kill @e[tag=role_card]