# 共通セットアップ
function my_pvp:debug/common_setup

# 2. スカウトに任命する
function my_pvp:roles/scout/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_scout_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『立体機動兵』","color":"aqua","bold":true},{"text":" に変更しました","color":"white"}]
