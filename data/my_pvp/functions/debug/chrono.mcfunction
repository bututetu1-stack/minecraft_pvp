# 共通セットアップ
function my_pvp:debug/common_setup

# 2. 時空跳躍者に任命する
function my_pvp:roles/chrono/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_chrono_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『時空跳躍者』","color":"yellow","bold":true},{"text":" に変更しました","color":"white"}]