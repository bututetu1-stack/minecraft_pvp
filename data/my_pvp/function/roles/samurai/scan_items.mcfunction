# 1. 所有者ID刻印 (侍用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{samurai_katana:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{samurai_zanshin:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{samurai_iai:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{samurai_hien:1b}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くの侍のIDを付与
execute as @e[tag=target_item] at @s if entity @p[tag=samurai,distance=..15] run scoreboard players operation @s player_id = @p[tag=samurai,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item

# 2. アイテム処理
# 刀 (投げ禁止 → 即回収)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{samurai_katana:1b}] at @s run function my_pvp:roles/samurai/process_katana

# 残心 (盾) も投げ禁止
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{samurai_zanshin:1b}] at @s run function my_pvp:roles/samurai/process_zanshin

# 居合 (スキル発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{samurai_iai:1b}] at @s run function my_pvp:roles/samurai/process_iai

# 飛燕 (スキル発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{samurai_hien:1b}] at @s run function my_pvp:roles/samurai/process_hien
