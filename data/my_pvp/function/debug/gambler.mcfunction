# 共通セットアップ
function my_pvp:debug/common_setup

# 2. ギャンブラーに任命する
function my_pvp:roles/gambler/assign

# デバッグ用：即座にアイテムを配布
function my_pvp:system/give_gambler_items

# デバッグ用：コインを最大まで付与
scoreboard players set @s coins 100

# 3. テスト用アナウンス
tellraw @s [{"text":"[Debug] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『ギャンブラー』","color":"green","bold":true},{"text":" に変更しました (Coins: 100)","color":"white"}]
