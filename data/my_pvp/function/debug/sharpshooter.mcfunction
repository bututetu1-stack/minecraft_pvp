# 共通セットアップ
function my_pvp:debug/common_setup

# 狙撃手に任命
function my_pvp:roles/sharpshooter/assign

# デバッグ用: 即座にアイテム配布
function my_pvp:system/give_sharpshooter_items

# テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『狙撃手』","color":"dark_gray","bold":true},{"text":" に変更しました","color":"white"}]
