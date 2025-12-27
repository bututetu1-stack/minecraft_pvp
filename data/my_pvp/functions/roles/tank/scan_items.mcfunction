# 1. 所有者ID刻印
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=tank,distance=..3] run scoreboard players operation @s player_id = @p[tag=tank,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 2. アイテム処理
# ハンマー (tank_hammerタグ付きシャベル)
execute as @e[type=item,nbt={Item:{tag:{tank_hammer:1b}}}] at @s run function my_pvp:roles/tank/process_hammer

# スキル (tank_skillタグ付きキノコ棒)
execute as @e[type=item,nbt={Item:{tag:{tank_skill:1b}}}] at @s run function my_pvp:roles/tank/process_skill