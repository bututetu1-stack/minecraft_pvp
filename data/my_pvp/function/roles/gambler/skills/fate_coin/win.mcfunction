# Fate Coin Win (利確)
# @s = player

# 1. Pot獲得
scoreboard players operation @s coins += @s fate_pot
tellraw @s [{"text":"[Fate] ","color":"aqua"},{"text":"COLLECT! ","color":"gold","bold":true},{"text":"獲得: ","color":"yellow"},{"score":{"name":"@s","objective":"fate_pot"},"color":"gold"}]

# 利確ボーナス: 次の攻撃1回のダメージ2倍 (gambler_main -> apply_damage_boost)
scoreboard players set @s damage_boost 1
tellraw @s {"text":"[Fate] 次の攻撃のダメージが2倍になる！","color":"aqua"}

# 2. リセット
scoreboard players set @s fate_pot 0
scoreboard players set @s fate_streak 0
scoreboard players set @s fate_timer 0

# アイテム更新
item replace entity @s hotbar.4 with minecraft:copper_ingot[custom_name='{"text":"運命のコイン","color":"aqua","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}','{"text":"利確すると次の攻撃ダメージ2倍","color":"aqua"}']]
