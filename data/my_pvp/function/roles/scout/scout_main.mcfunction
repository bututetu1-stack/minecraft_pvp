# 1. UI表示
# ワイヤー移動中は警告を表示
execute if entity @s[tag=is_grappling] run title @s actionbar [{"text":">> GRAPPLING <<","color":"aqua","bold":true}]

# 通常時 (ワイヤーにCTは無い)
execute unless entity @s[tag=is_grappling] run title @s actionbar [{"text":"Wire: ","color":"aqua"},{"text":"READY","color":"white"}]

# --- 3. 矢の発射検知 ---
scoreboard players operation #TEMP player_id = @s player_id
execute as @e[type=arrow,tag=!wire_arrow,distance=..5] if score @p[tag=scout,distance=..5] player_id = #TEMP player_id run function my_pvp:roles/scout/init_arrow

# --- 4. 矢の処理 (着弾検知) ---
execute as @e[type=arrow,tag=wire_arrow] at @s run function my_pvp:roles/scout/arrow_tick

# --- 5. ワイヤー移動処理 ---
execute if entity @s[tag=is_grappling] run function my_pvp:roles/scout/pull_logic

# --- 6. アイテム保護・返却 (弓・剣・矢のドロップ) ---
function my_pvp:roles/scout/scan_items