attribute @s minecraft:max_health base set 40.0
effect give @s minecraft:instant_health 1 100 true
tag @s add pending_heal

function my_pvp:system/give_gambler_items

# 通常リスポーン: 50コイン
# 通常リスポーン (0以上): 50コイン
execute if score @s coins matches 0.. run scoreboard players set @s coins 50

# 破産死リスポーン (負の数): 10コイン
execute if score @s coins matches ..-1 run tellraw @s {"text":"[Fate] 破産ペナルティ... (所持金 10)","color":"red"}
execute if score @s coins matches ..-1 run scoreboard players set @s coins 10
# tellraw @s {"text":"[System] ステータスが復旧しました。","color":"green"}
