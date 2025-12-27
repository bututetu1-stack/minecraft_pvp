# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove role_assigned

# 2. 忍者に任命する
function my_pvp:roles/ninja/assign

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"忍者に変更しました","color":"dark_purple"}]