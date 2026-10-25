# 1. 所有者ID刻印 (魔術師のアイテムだけ)
# ※ 他役職のアイテムに刻印すると、その役職側の ID 照合が失敗してアイテムが消えるため対象を絞る
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{magician_broom:1b}] at @s if entity @p[tag=magician,distance=..6] run scoreboard players operation @s player_id = @p[tag=magician,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{magician_book:1b}] at @s if entity @p[tag=magician,distance=..6] run scoreboard players operation @s player_id = @p[tag=magician,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{magician_shockwave:1b}] at @s if entity @p[tag=magician,distance=..6] run scoreboard players operation @s player_id = @p[tag=magician,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{magician_inferno:1b}] at @s if entity @p[tag=magician,distance=..6] run scoreboard players operation @s player_id = @p[tag=magician,limit=1,sort=nearest] player_id

# ID付与成功時のみフラグを立てる
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 2. アイテム処理

# 魔術箒 (ドロップ -> 飛行トグル)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{magician_broom:1b}] at @s run function my_pvp:roles/magician/process_broom_drop

# 魔術本 (ドロップ -> 炎玉発射)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{magician_book:1b}] at @s run function my_pvp:roles/magician/process_book_drop

# 衝撃符 (ドロップ -> 衝撃波)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{magician_shockwave:1b}] at @s run function my_pvp:roles/magician/process_shockwave_drop

# 業火符 (ドロップ -> 業火爆裂)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{magician_inferno:1b}] at @s run function my_pvp:roles/magician/process_inferno_drop
