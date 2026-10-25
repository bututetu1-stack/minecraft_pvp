clear @s

# Slot 0: 剣
item replace entity @s hotbar.0 with minecraft:iron_sword[minecraft:custom_data={gambler_sword:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"ギャンブラーの剣","color":"gray","italic":false}']

# Slot 1: ブラックジャック (鉄インゴット)
item replace entity @s hotbar.1 with minecraft:iron_ingot[minecraft:custom_name='{"text":"ブラックジャック","color":"gold","italic":false}',minecraft:lore=['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']]

# Slot 2: オール・イン (金塊)
item replace entity @s hotbar.2 with minecraft:gold_nugget[minecraft:custom_name='{"text":"オール・イン","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']]

# Slot 3: ルーレット (ガストの涙)
item replace entity @s hotbar.3 with minecraft:ghast_tear[minecraft:custom_name='{"text":"運命のルーレット","color":"light_purple","italic":false}',minecraft:lore=['{"text":"[Q]キーでドロップして開始 (25 Coins)","color":"gray"}']]

# Slot 4: 運命のコイン (銅インゴット)
item replace entity @s hotbar.4 with minecraft:copper_ingot[minecraft:custom_name='{"text":"運命のコイン","color":"aqua","italic":false}',minecraft:lore=['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}','{"text":"利確すると次の攻撃ダメージ2倍","color":"aqua"}']]

# Slot 5: 宣戦布告 (赤色の染料)
# [重要] 攻撃して発動
item replace entity @s hotbar.5 with minecraft:red_dye[minecraft:custom_data={gambler_war:1b},minecraft:custom_name='{"text":"宣戦布告","color":"dark_red","italic":false}',minecraft:lore=['{"text":"攻撃して発動 (50 Coins)","color":"gray"}']]
