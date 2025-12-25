# --- 1. アイテムに所有者IDを刻印 ---
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=ninja,distance=..3] run scoreboard players operation @s player_id = @p[tag=ninja,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# --- 2. 各アイテムの処理へ振り分け ---
# 忍刀 (Qで落とした場合 -> 即返却)
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_sword"}}] at @s run function my_pvp:roles/ninja/process_sword

# 変わり身の杖 (Qで落とした場合 -> 即返却)
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}}] at @s run function my_pvp:roles/ninja/process_rod

# 影縫い (Qで発動 -> 返却 & スキル処理)
execute as @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}] at @s run function my_pvp:roles/ninja/use_mark

# 煙玉 (Qで発動 -> 返却 & スキル処理)
execute as @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}] at @s run function my_pvp:roles/ninja/use_smoke