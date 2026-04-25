# 共通セットアップ
function my_pvp:debug/common_setup

# 2. 侍に任命する
function my_pvp:roles/samurai/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_samurai_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『侍』","color":"red","bold":true},{"text":" に変更しました","color":"white"}]
