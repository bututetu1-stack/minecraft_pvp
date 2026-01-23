attribute @s minecraft:generic.max_health base set 40.0
effect give @s minecraft:instant_health 1 100 true
tag @s add pending_heal

function my_pvp:system/give_gambler_items

scoreboard players set @s coins 50
# tellraw @s {"text":"[System] ステータスが復旧しました。","color":"green"}
