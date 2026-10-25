# 共通セットアップ
function my_pvp:debug/common_setup

# 獣使いに任命
function my_pvp:roles/beastmaster/assign

# デバッグ用: 即座にアイテム配布
function my_pvp:system/give_beastmaster_items

# テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『獣使い』","color":"gray","bold":true},{"text":" に変更しました","color":"white"}]
