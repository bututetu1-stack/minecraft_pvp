# 1. UI表示
# ワイヤー移動中は警告を表示
execute if entity @s[tag=is_grappling] run title @s actionbar [{"text":">> GRAPPLING <<","color":"aqua","bold":true}]

# 通常時はクールダウンを表示
execute unless entity @s[tag=is_grappling] run title @s actionbar [{"text":"Wire: ","color":"aqua"},{"score":{"name":"@s","objective":"cd_wire"},"color":"white"}]

# 2. クールダウン消化
scoreboard players remove @s[scores={cd_wire=1..}] cd_wire 1
execute if score @s cd_wire matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# --- 3. 矢の発射検知 ---
scoreboard players operation #TEMP player_id = @s player_id
execute as @e[type=arrow,tag=!wire_arrow,distance=..5] if score @p[tag=scout,distance=..5] player_id = #TEMP player_id run function my_pvp:roles/scout/init_arrow

# --- 4. 矢の処理 (着弾検知) ---
execute as @e[type=arrow,tag=wire_arrow] at @s run function my_pvp:roles/scout/arrow_tick

# --- 5. ワイヤー移動処理 ---
execute if entity @s[tag=is_grappling] run function my_pvp:roles/scout/pull_logic

# --- 6. アイテム保護・返却 (弓・剣・矢のドロップ) ---
function my_pvp:roles/scout/scan_items

# 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump