# 1. 所有者ID刻印 (機械工用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク (ガジェット類とレンチ)
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{is_gadget:1b}}}] run tag @s add target_item
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{is_wrench:1b}}}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くの機械工のIDを付与
execute as @e[tag=target_item] at @s if entity @p[tag=mechanic,distance=..3] run scoreboard players operation @s player_id = @p[tag=mechanic,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s run function my_pvp:roles/mechanic/process_torch
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s run function my_pvp:roles/mechanic/process_mine
execute as @e[type=item,nbt={Item:{id:"minecraft:piston"}}] at @s run function my_pvp:roles/mechanic/process_launcher
execute as @e[type=item,nbt={Item:{id:"minecraft:compass"}}] at @s run function my_pvp:roles/mechanic/process_snare

# レンチのタグを持っている場合のみ処理
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_axe",tag:{is_wrench:1b}}}] at @s run function my_pvp:roles/mechanic/process_wrench