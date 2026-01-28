# Fate Coin Game Loop (毎tick実行)
# @s = player

# ゲーム中でなければ終了
execute unless score @s fate_streak matches 1.. run return 0

# タイマー加算
scoreboard players add @s fate_timer 1

# タイマー表示 (残り秒数)
execute if score @s fate_streak matches 1.. run title @s actionbar [{"text":"[Fate] Win: ","color":"gold"},{"score":{"name":"@s","objective":"fate_pot"}},{"text":" | Collectまで: ","color":"yellow"},{"score":{"name":"@s","objective":"fate_timer"},"color":"red"},{"text":"/60","color":"gray"}]

# 3秒経過 (60 ticks) で自動Collect (利確)
execute if score @s fate_timer matches 60.. run function my_pvp:roles/gambler/skills/fate_coin/win
