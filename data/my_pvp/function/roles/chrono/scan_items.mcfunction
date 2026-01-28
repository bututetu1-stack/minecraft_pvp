# --- アイテムドロップ検知 (Chronomancer) ---

# 1. タイム・リバース (青い砂時計)
execute as @e[type=item] if items entity @s contents *[minecraft:custom_data~{chrono_reverse:1b}] at @s run function my_pvp:roles/chrono/process_reverse

# 2. 時空の静止 (黄色の砂時計)
execute as @e[type=item] if items entity @s contents *[minecraft:custom_data~{chrono_stasis:1b}] at @s run function my_pvp:roles/chrono/process_stasis

# 3. クロック・アップ (赤い砂時計)
execute as @e[type=item] if items entity @s contents *[minecraft:custom_data~{chrono_clockup:1b}] at @s run function my_pvp:roles/chrono/process_clockup

# 4. 刻の宝剣 (Iron Sword)
execute as @e[type=item] if items entity @s contents minecraft:iron_sword at @s if entity @p[tag=chrono,distance=..3] run item replace entity @p[tag=chrono,distance=..3] hotbar.0 with minecraft:iron_sword[minecraft:custom_name='{"text":"刻の宝剣","color":"aqua","italic":false}']
execute as @e[type=item] if items entity @s contents minecraft:iron_sword at @s if entity @p[tag=chrono,distance=..3] run kill @s