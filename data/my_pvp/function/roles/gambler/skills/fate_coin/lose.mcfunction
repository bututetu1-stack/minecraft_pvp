# Fate Coin Lose (没収 & ペナルティ)
# @s = player

# 1. ペナルティ (負ける直前の賭け金 = Pot を失う)
tellraw @s [{"text":"[Fate] ","color":"red"},{"text":"PENALTY! ","color":"dark_red","bold":true},{"text":"失った金額: ","color":"yellow"},{"score":{"name":"@s","objective":"fate_pot"},"color":"red"}]
scoreboard players operation @s coins -= @s fate_pot

# 2. Potリセット
scoreboard players set @s fate_pot 0
scoreboard players set @s fate_streak 0
scoreboard players set @s fate_timer 0

# 2. 借金による破産チェック
# コインが -40 以下なら死亡
execute if score @s coins matches ..-41 run function my_pvp:roles/gambler/skills/fate_coin/bankruptcy

# アイテム更新
item replace entity @s hotbar.4 with minecraft:copper_ingot[custom_name='{"text":"運命のコイン","color":"aqua","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}']]
