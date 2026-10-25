# 1. 所有者ID刻印 (タンク用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{tank_hammer:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{tank_skill:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{tank_shield:1b}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くのタンクのIDを付与
execute as @e[tag=target_item] at @s if entity @p[tag=tank,distance=..15] run scoreboard players operation @s player_id = @p[tag=tank,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{tank_hammer:1b}] at @s run function my_pvp:roles/tank/process_hammer
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{tank_skill:1b}] at @s run function my_pvp:roles/tank/process_skill
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{tank_shield:1b}] at @s run function my_pvp:roles/tank/shield_bash/process_shield
