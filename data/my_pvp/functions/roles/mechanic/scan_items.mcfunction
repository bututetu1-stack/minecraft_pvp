# アイテムに所有者IDを刻印 (投げた瞬間に確定)
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=mechanic,distance=..3] run scoreboard players operation @s player_id = @p[tag=mechanic,limit=1,sort=nearest] player_id

# 【修正】IDが1以上（正常に付与された）の場合のみ、登録済みタグを付ける
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 各アイテム処理
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s run function my_pvp:roles/mechanic/process_torch
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s run function my_pvp:roles/mechanic/process_mine
execute as @e[type=item,nbt={Item:{id:"minecraft:piston"}}] at @s run function my_pvp:roles/mechanic/process_launcher
execute as @e[type=item,nbt={Item:{id:"minecraft:compass"}}] at @s run function my_pvp:roles/mechanic/process_snare
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_axe"}}] at @s run function my_pvp:roles/mechanic/process_wrench