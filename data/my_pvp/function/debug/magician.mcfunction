# 共通セットアップ
function my_pvp:debug/common_setup

# 2. 魔術師に任命する
function my_pvp:roles/magician/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_magician_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『魔術師』","color":"light_purple","bold":true},{"text":" に変更しました","color":"white"}]
