execute if score @s coins matches ..29 run tellraw @s {"text":"[System] コインが足りません (必要: 30)","color":"red"}
execute if score @s coins matches ..29 run item replace entity @s hotbar.1 with minecraft:iron_ingot{display:{Name:'{"text":"ブラックジャック","color":"gold","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']}}
execute if score @s coins matches ..29 run return 0

scoreboard players remove @s coins 30
tellraw @s {"text":"[BJ] ブラックジャックを開始します (-30 Coins)","color":"gold"}

scoreboard players set @s bj_state 1
scoreboard players set @s bj_timer 0

summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score @s bj_hand run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]

scoreboard players set #10 temp 10
scoreboard players operation @s bj_hand %= #10 temp
execute if score @s bj_hand matches ..0 run scoreboard players add @s bj_hand 10
execute if score @s bj_hand matches 0 run scoreboard players set @s bj_hand 10

tellraw @s [{"text":"[BJ] 現在の手札: ","color":"yellow"},{"score":{"name":"@s","objective":"bj_hand"},"color":"aqua","bold":true}]
tellraw @s {"text":"操作: スロット1(鉄)をドロップで[HIT], 3秒放置で[STAY]","color":"green"}

item replace entity @s hotbar.1 with minecraft:iron_ingot{display:{Name:'{"text":"ブラックジャック","color":"gold","italic":false}',Lore:['{"text":"ドロップ:[HIT] / 3秒放置:[STAY]","color":"green"}']}}
