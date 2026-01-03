# --- アイテムドロップ検知 (Chronomancer) ---

# 1. タイム・リバース (青い砂時計)
execute as @e[type=item,nbt={Item:{tag:{chrono_reverse:1b}}}] at @s run function my_pvp:roles/chrono/process_reverse

# 2. 時空の静止 (黄色の砂時計)
execute as @e[type=item,nbt={Item:{tag:{chrono_stasis:1b}}}] at @s run function my_pvp:roles/chrono/process_stasis

# 3. クロック・アップ (赤い砂時計)
execute as @e[type=item,nbt={Item:{tag:{chrono_clockup:1b}}}] at @s run function my_pvp:roles/chrono/process_clockup