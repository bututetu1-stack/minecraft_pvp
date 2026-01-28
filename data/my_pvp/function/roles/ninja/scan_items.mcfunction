# 1. 所有者ID刻印
tag @e[type=item,tag=!id_set] remove target_item

# --- 対象アイテムをマーク (ここはそのままでOK) ---
# --- 対象アイテムをマーク (ここはそのままでOK) ---
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{ninja_sword:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents minecraft:black_dye run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents minecraft:charcoal run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents minecraft:carrot_on_a_stick run tag @s add target_item

# --- ID付与処理 (そのまま) ---
execute as @e[tag=target_item] at @s if entity @p[tag=ninja,distance=..5] run scoreboard players operation @s player_id = @p[tag=ninja,limit=1,sort=nearest] player_id
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set
tag @e[tag=target_item] remove target_item


# 2. アイテム処理関数の呼び出し
# 忍刀
execute as @e[type=item] if items entity @s contents *[minecraft:custom_data~{ninja_sword:1b}] at @s run function my_pvp:roles/ninja/process_sword
# 影縫い
execute as @e[type=item] if items entity @s contents minecraft:black_dye at @s run function my_pvp:roles/ninja/process_mark
# 煙玉
execute as @e[type=item] if items entity @s contents minecraft:charcoal at @s run function my_pvp:roles/ninja/process_smoke

# 変わり身の杖
# 【修正】提督のアイテム(adm_~)を除外(unless)します (custom_dataで除外)
execute as @e[type=item] if items entity @s contents minecraft:carrot_on_a_stick unless items entity @s contents *[minecraft:custom_data~{adm_artillery:1b}] unless items entity @s contents *[minecraft:custom_data~{adm_torpedo:1b}] unless items entity @s contents *[minecraft:custom_data~{adm_air:1b}] unless items entity @s contents *[minecraft:custom_data~{adm_aa:1b}] at @s run function my_pvp:roles/ninja/process_rod