# 共通セットアップ
function my_pvp:debug/common_setup

# 2. 機械工に任命する
function my_pvp:roles/mechanic/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_mechanic_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『機械工』","color":"gold","bold":true},{"text":" に変更しました","color":"white"}]
