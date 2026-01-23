summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #NEW_CARD temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]

scoreboard players set #10 temp 10
scoreboard players operation #NEW_CARD temp %= #10 temp
execute if score #NEW_CARD temp matches ..0 run scoreboard players add #NEW_CARD temp 10
execute if score #NEW_CARD temp matches 0 run scoreboard players set #NEW_CARD temp 10

scoreboard players operation @s bj_hand += #NEW_CARD temp

tellraw @s [{"text":"[BJ] ","color":"gold"},{"text":"HIT! ","color":"green","bold":true},{"text":"カード: ","color":"gray"},{"score":{"name":"#NEW_CARD","objective":"temp"},"color":"white"}]
tellraw @s [{"text":"[BJ] 現在の手札: ","color":"yellow"},{"score":{"name":"@s","objective":"bj_hand"},"color":"aqua","bold":true}]

execute if score @s bj_hand matches 22.. run function my_pvp:roles/gambler/skills/blackjack/burst
execute unless score @s bj_hand matches 22.. run scoreboard players set @s bj_timer 0
execute unless score @s bj_hand matches 22.. run tellraw @s {"text":"操作: スロット1(鉄)をドロップで[HIT], 3秒放置で[STAY]","color":"green"}
