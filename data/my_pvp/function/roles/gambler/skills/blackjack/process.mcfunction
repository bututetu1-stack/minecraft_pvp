execute if score @s bj_action matches 1 run function my_pvp:roles/gambler/skills/blackjack/hit
execute if score @s bj_action matches 2 run function my_pvp:roles/gambler/skills/blackjack/stay
scoreboard players set @s bj_action 0
