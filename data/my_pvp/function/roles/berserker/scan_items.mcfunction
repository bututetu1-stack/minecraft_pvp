# Unconditional Verification

# 1. 所有者ID刻印 (バーサーカー用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# Generic Debug
# execute as @e[type=item] run tellraw @a {"text":"[Debug] Item Scanned","color":"gray"}

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{berserker_axe:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{berserker_raid:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{berserker_jump:1b}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くのバーサーカーのIDを付与
# 感知範囲は 15 のまま維持
execute as @e[tag=target_item] at @s if entity @p[tag=berserker,distance=..15] run scoreboard players operation @s player_id = @p[tag=berserker,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理 (ここは変更なし)
# 斧 (投げ禁止 -> 即回収)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{berserker_axe:1b}] at @s run function my_pvp:roles/berserker/process_axe

# ブラッドクリスタル (スキル発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{berserker_raid:1b}] at @s run function my_pvp:roles/berserker/process_raid

# リープフェザー (スキル発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{berserker_jump:1b}] at @s run function my_pvp:roles/berserker/process_feather