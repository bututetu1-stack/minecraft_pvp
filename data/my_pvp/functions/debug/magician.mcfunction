# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove tank
tag @s remove berserker
tag @s remove magician
tag @s remove role_assigned

# 飛行状態もリセット
tag @s remove mag_flying
effect clear @s minecraft:slow_falling

# IDがない場合は付与する（安全装置）
execute unless score @s player_id matches 1.. run function my_pvp:system/assign_new_id

# 2. 魔術師に任命する
function my_pvp:roles/magician/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_magician_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"魔術師に変更しました","color":"light_purple"}]
