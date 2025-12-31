# 共通セットアップ
function my_pvp:debug/common_setup

# 2. ストーカーに任命する
function my_pvp:roles/stalker/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_stalker_items

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『ストーカー』","color":"dark_red","bold":true},{"text":" に変更しました","color":"white"}]
