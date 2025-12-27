# 1. アイテムに所有者IDを刻印
# 【修正】distance=..6 に拡大
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=scout,distance=..6] run scoreboard players operation @s player_id = @p[tag=scout,limit=1,sort=nearest] player_id

# IDが正常に付与されたらタグ付け
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 2. 各アイテム処理
# ワイヤーボウ
execute as @e[type=item,nbt={Item:{tag:{Tags:["scout_bow"]}}}] at @s run function my_pvp:roles/scout/process_bow

# リパルサーブレード
execute as @e[type=item,nbt={Item:{tag:{scout_sword:1b}}}] at @s run function my_pvp:roles/scout/process_sword

# 矢
execute as @e[type=item,nbt={Item:{tag:{scout_arrow:1b}}}] at @s run function my_pvp:roles/scout/process_arrow