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

# 2. 忍者に任命する
function my_pvp:roles/ninja/assign

# ▼▼▼ 追加 ▼▼▼
# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_ninja_items
# ▲▲▲ 追加ここまで ▲▲▲

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"忍者に変更しました","color":"dark_purple"}]
