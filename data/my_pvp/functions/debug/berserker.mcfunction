# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove tank
tag @s remove berserker
tag @s remove role_assigned
execute unless score @s player_id matches 1.. run function my_pvp:system/assign_new_id

# 2. バーサーカーに任命する
function my_pvp:roles/berserker/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_berserker_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"バーサーカーに変更しました","color":"red"}]