# 1. 所有者ID刻印 (ストーカー用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{is_stalker_weapon:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{is_tracking_compass:1b}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くのストーカーのIDを付与
execute as @e[tag=target_item] at @s if entity @p[tag=stalker,distance=..15] run scoreboard players operation @s player_id = @p[tag=stalker,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{is_stalker_weapon:1b}}}}] at @s run function my_pvp:roles/stalker/process_weapon
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{is_tracking_compass:1b}}}}] at @s run function my_pvp:roles/stalker/process_compass