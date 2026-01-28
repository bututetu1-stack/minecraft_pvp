# 彫刻家のアイテムスキャン処理
# game_logic から @e[type=item] として実行される

# 1. 所有者ID刻印
tag @e[type=item,tag=!id_set] remove target_item

# --- 対象アイテムをマーク (彫刻刀のみ) ---
execute as @e[type=item,tag=!id_set,nbt={Item:{components:{"minecraft:custom_data":{sculptor_chisel:1b}}}}] run tag @s add target_item

# --- ID付与処理 ---
execute as @e[tag=target_item] at @s if entity @p[tag=sculptor,distance=..5] run scoreboard players operation @s player_id = @p[tag=sculptor,limit=1,sort=nearest] player_id
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set
tag @e[tag=target_item] remove target_item

# 2. アイテム処理関数の呼び出し
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{sculptor_chisel:1b}}}}] at @s run function my_pvp:roles/sculptor/process_chisel
