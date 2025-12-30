# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove tank
tag @s remove berserker
tag @s remove magician
tag @s remove mag_flying_true
tag @s add mag_flying_false
tag @s remove role_assigned

# 2. 機械工に任命する
function my_pvp:roles/mechanic/assign

# ▼▼▼ 追加 ▼▼▼
# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_mechanic_items
# ▲▲▲ 追加ここまで ▲▲▲

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"機械工に変更しました","color":"gold"}]
