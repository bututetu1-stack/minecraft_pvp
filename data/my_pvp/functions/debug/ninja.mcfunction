# 共通セットアップ
function my_pvp:debug/common_setup

# 2. 忍者に任命する
function my_pvp:roles/ninja/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_ninja_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『忍者』","color":"dark_purple","bold":true},{"text":" に変更しました","color":"white"}]
