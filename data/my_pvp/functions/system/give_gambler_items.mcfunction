clear @s

# Slot 0: 剣
item replace entity @s hotbar.0 with minecraft:iron_sword{display:{Name:'{"text":"ギャンブラーの剣","color":"gray","italic":false}'}}

# Slot 1: ブラックジャック (鉄インゴット)
item replace entity @s hotbar.1 with minecraft:iron_ingot{display:{Name:'{"text":"ブラックジャック","color":"gold","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']}}

# Slot 2: オール・イン (金塊)
item replace entity @s hotbar.2 with minecraft:gold_nugget{display:{Name:'{"text":"オール・イン","color":"yellow","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']}}

# Slot 3: ルーレット (ガストの涙)
item replace entity @s hotbar.3 with minecraft:ghast_tear{display:{Name:'{"text":"運命のルーレット","color":"light_purple","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (25 Coins)","color":"gray"}']}}

# Slot 4: 運命のコイン (銅インゴット)
item replace entity @s hotbar.4 with minecraft:copper_ingot{display:{Name:'{"text":"運命のコイン","color":"aqua","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}']}}

# Slot 5: 宣戦布告 (赤色の染料)
# [重要] 攻撃して発動
item replace entity @s hotbar.5 with minecraft:red_dye{display:{Name:'{"text":"宣戦布告","color":"dark_red","italic":false}',Lore:['{"text":"攻撃して発動 (50 Coins)","color":"gray"}']}}
