# 1. 所有者ID刻印 (狙撃手用アイテムのみ)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_bow:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_focus:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_snipe:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_smoke:1b}] run tag @s add target_item

# 近距離(半径15)の狙撃手から player_id を継承
execute as @e[tag=target_item] at @s if entity @p[tag=sharpshooter,distance=..15] run scoreboard players operation @s player_id = @p[tag=sharpshooter,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理 (id_set 必須)
# 弓 (投げ禁止 → 即時返却)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_bow:1b}] at @s run function my_pvp:roles/sharpshooter/process_bow
# スコープ (投げ禁止 → 即時返却)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_focus:1b}] at @s run function my_pvp:roles/sharpshooter/process_focus
# 狙撃弾 (発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_snipe:1b}] at @s run function my_pvp:roles/sharpshooter/process_snipe
# 煙幕弾 (発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{sharpshooter_smoke:1b}] at @s run function my_pvp:roles/sharpshooter/process_smoke
