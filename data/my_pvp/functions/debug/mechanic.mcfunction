# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove role_assigned

# 2. 機械工に任命する
function my_pvp:roles/mechanic/assign

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"機械工に変更しました","color":"gold"}]