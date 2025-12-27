# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove role_assigned

# 2. スカウトに任命する
function my_pvp:roles/scout/assign

# 3. デバッグ用：即座にアイテムを配布
function my_pvp:system/give_scout_items

# 4. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"スカウトに変更しました","color":"aqua"}]