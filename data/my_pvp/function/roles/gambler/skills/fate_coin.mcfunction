# 運命のコイン (Fate Coin)
# @s = player

# 1. 既にゲーム中なら「フリップ（ダブルアップ）」へ
tag @s remove fate_running
execute if score @s fate_streak matches 1.. run tag @s add fate_running

execute if entity @s[tag=fate_running] run function my_pvp:roles/gambler/skills/fate_coin/flip
execute if entity @s[tag=fate_running] run return 0

# 2. 借金チェック
execute if score @s coins matches ..-1 run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"借金中はギャンブルを行えません","color":"red"}]
execute if score @s coins matches ..-1 run item replace entity @s hotbar.4 with minecraft:copper_ingot[custom_name='{"text":"運命のコイン","color":"aqua","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}']]
execute if score @s coins matches ..-1 run return 0

# 3. 開始処理
# コイン消費 (借金可能)
# コイン消費 (借金可能)
execute unless entity @s[tag=rush_mode] run scoreboard players remove @s coins 5
tellraw @s {"text":"[Fate] 運命のコイン開始! (Pot: 10)","color":"aqua"}

# 初期化
scoreboard players set @s fate_pot 10
scoreboard players set @s fate_streak 1
scoreboard players set @s fate_timer 0

# 初回フリップ実行
function my_pvp:roles/gambler/skills/fate_coin/flip

# アイテム補充
item replace entity @s hotbar.4 with minecraft:copper_ingot[custom_name='{"text":"運命のコイン","color":"aqua","italic":false}',lore=['{"text":"[Q]キーでドロップして開始/継続","color":"gray"}']]
