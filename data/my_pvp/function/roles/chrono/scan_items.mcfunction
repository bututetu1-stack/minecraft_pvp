# --- アイテムドロップ検知 (Chronomancer) ---

# 1. 所有者ID刻印 (chrono用スキルアイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{chrono_reverse:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{chrono_stasis:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{chrono_clockup:1b}] run tag @s add target_item

# 近距離(半径15)のchronoから player_id を継承
execute as @e[tag=target_item] at @s if entity @p[tag=chrono,distance=..15] run scoreboard players operation @s player_id = @p[tag=chrono,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理 (id_set 必須)
# タイム・リバース (青い砂時計)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{chrono_reverse:1b}] at @s run function my_pvp:roles/chrono/process_reverse

# 時空の静止 (黄色の砂時計)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{chrono_stasis:1b}] at @s run function my_pvp:roles/chrono/process_stasis

# クロック・アップ (赤い砂時計)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{chrono_clockup:1b}] at @s run function my_pvp:roles/chrono/process_clockup

# 3. 刻の宝剣 (Iron Sword) - 既存処理 (近接マッチ維持)
execute as @e[type=item] if items entity @s contents minecraft:iron_sword at @s if entity @p[tag=chrono,distance=..3] run item replace entity @p[tag=chrono,distance=..3] hotbar.0 with minecraft:iron_sword[minecraft:custom_name='{"text":"刻の宝剣","color":"aqua","italic":false}']
execute as @e[type=item] if items entity @s contents minecraft:iron_sword at @s if entity @p[tag=chrono,distance=..3] run kill @s
