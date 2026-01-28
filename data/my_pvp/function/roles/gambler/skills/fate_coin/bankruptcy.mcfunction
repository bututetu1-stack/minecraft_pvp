# 破産処理
# @s = player

tellraw @a [{"selector":"@s","color":"yellow"},{"text":" は破産しました...","color":"dark_red","bold":true}]
kill @s

scoreboard players set @s coins -100
tag @s add bankrupt_death
