# 共通セットアップ
function my_pvp:debug/common_setup

# 2. タンクに任命する
function my_pvp:roles/tank/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_tank_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『タンク』","color":"dark_green","bold":true},{"text":" に変更しました","color":"white"}]
