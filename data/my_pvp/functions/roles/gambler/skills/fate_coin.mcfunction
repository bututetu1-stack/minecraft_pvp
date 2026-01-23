# 運命のコイン (Fate Coin)
# @s = player

# コインチェック (5枚)
execute if score @s coins matches ..4 run tellraw @s {"text":"[System] コインが足りません (必要: 5)","color":"red"}
execute if score @s coins matches ..4 run item replace entity @s hotbar.4 with minecraft:copper_ingot{display:{Name:'{"text":"運命のコイン","color":"aqua","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}']}}
execute if score @s coins matches ..4 run return 0

# コイン消費
scoreboard players remove @s coins 5
tellraw @s {"text":"[Fate] コイントス...","color":"aqua"}

# 50%判定
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #RND temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players set #2 temp 2
scoreboard players operation #RND temp %= #2 temp

# 表 (Success)
execute unless score #RND temp matches 0 run tellraw @s {"text":"[Fate] 表！ (次の攻撃ダメージ2倍)","color":"aqua","bold":true}
execute unless score #RND temp matches 0 run scoreboard players set @s damage_boost 1

# 裏 (Fail)
execute if score #RND temp matches 0 run tellraw @s {"text":"[Fate] 裏... (8ダメージを受ける)","color":"gray","bold":true}
execute if score #RND temp matches 0 run damage @s 8 minecraft:magic

# アイテム補充
item replace entity @s hotbar.4 with minecraft:copper_ingot{display:{Name:'{"text":"運命のコイン","color":"aqua","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (5 Coins)","color":"gray"}']}}
