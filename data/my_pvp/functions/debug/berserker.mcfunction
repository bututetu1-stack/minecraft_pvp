# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove tank
tag @s remove berserker
tag @s remove magician
tag @s remove mag_flying
tag @s remove role_assigned

# IDがない場合は付与する（安全装置）
execute unless score @s player_id matches 1.. run function my_pvp:system/assign_new_id

# 2. バーサーカーに任命する
function my_pvp:roles/berserker/assign

# デバッグ用：即座にアイテムを配布
# (試合開始時以外でもテストできるように、ここで直接アイテム配布関数を呼びます)
function my_pvp:system/give_berserker_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"バーサーカーに変更しました","color":"red"}]
