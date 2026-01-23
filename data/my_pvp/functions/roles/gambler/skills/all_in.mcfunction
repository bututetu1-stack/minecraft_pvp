# オール・イン (All-In)
# @s = player

# コインチェック (40枚以上)
execute if score @s coins matches ..39 run tellraw @s {"text":"[System] コインが足りません (必要: 40以上)","color":"red"}
execute if score @s coins matches ..39 run item replace entity @s hotbar.2 with minecraft:gold_nugget{display:{Name:'{"text":"オール・イン","color":"yellow","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']}}
execute if score @s coins matches ..39 run return 0

# 消費前の枚数取得
scoreboard players operation #SPENT_COINS temp = @s coins

# 全消費
scoreboard players set @s coins 0
tellraw @s [{"text":"[All-In] ","color":"dark_red","bold":true},{"text":"全財産 ","color":"yellow"},{"score":{"name":"#SPENT_COINS","objective":"temp"}},{"text":"枚を賭けます...","color":"yellow"}]

# 50%判定
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #RND temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players set #2 temp 2
scoreboard players operation #RND temp %= #2 temp

# 0 = 失敗, 1 (or -1) = 成功
# 偶数奇数判定。

# 成功 (Success)
execute unless score #RND temp matches 0 run function my_pvp:roles/gambler/skills/all_in_success

# 失敗 (Fail)
execute if score #RND temp matches 0 run function my_pvp:roles/gambler/skills/all_in_fail

# アイテム補充
item replace entity @s hotbar.2 with minecraft:gold_nugget{display:{Name:'{"text":"オール・イン","color":"yellow","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']}}
