# 共通セットアップ
function my_pvp:debug/common_setup

# 2. 提督に任命する
function my_pvp:roles/admiral/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_admiral_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『提督』","color":"dark_aqua","bold":true},{"text":" に変更しました","color":"white"}]
