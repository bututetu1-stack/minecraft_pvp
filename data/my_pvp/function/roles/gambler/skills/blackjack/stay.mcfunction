tellraw @s {"text":"[BJ] STAY! 勝負します...","color":"red","bold":true}

summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score @s bj_dealer run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]

scoreboard players set #6 temp 6
scoreboard players operation @s bj_dealer %= #6 temp
execute if score @s bj_dealer matches ..-1 run scoreboard players add @s bj_dealer 6
scoreboard players add @s bj_dealer 15

tellraw @s [{"text":"[BJ] あなた: ","color":"aqua"},{"score":{"name":"@s","objective":"bj_hand"},"bold":true},{"text":" vs ","color":"gray"},{"text":"ディーラー: ","color":"red"},{"score":{"name":"@s","objective":"bj_dealer"},"bold":true}]

execute if score @s bj_hand matches 21 run function my_pvp:roles/gambler/skills/blackjack/blackjack_win
execute unless score @s bj_hand matches 21 if score @s bj_hand > @s bj_dealer run function my_pvp:roles/gambler/skills/blackjack/win
execute unless score @s bj_hand matches 21 if score @s bj_hand < @s bj_dealer run function my_pvp:roles/gambler/skills/blackjack/lose

execute if score @s bj_hand = @s bj_dealer run tellraw @s {"text":"[BJ] 引き分け (コイン返還)","color":"gray"}
execute if score @s bj_hand = @s bj_dealer run scoreboard players add @s coins 30

scoreboard players set @s bj_state 0
