# 1. 所有者ID刻印 (スカウト用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{Tags:["scout_bow"]}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{scout_sword:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{scout_arrow:1b}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くのスカウトのIDを付与
execute as @e[tag=target_item] at @s if entity @p[tag=scout,distance=..15] run scoreboard players operation @s player_id = @p[tag=scout,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{Tags:["scout_bow"]}] at @s run function my_pvp:roles/scout/process_bow
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{scout_sword:1b}] at @s run function my_pvp:roles/scout/process_sword
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{scout_arrow:1b}] at @s run function my_pvp:roles/scout/process_arrow
