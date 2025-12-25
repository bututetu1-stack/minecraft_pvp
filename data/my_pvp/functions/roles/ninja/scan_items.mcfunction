# 1. アイテムに所有者IDを刻印 (投げた瞬間に確定)
# まだIDがない(@s[tag=!id_set])アイテムに対して、近くの忍者のIDをコピー
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=ninja,distance=..3] run scoreboard players operation @s player_id = @p[tag=ninja,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] run tag @s add id_set

# --- スキル1: 影縫い (設置) ---
execute as @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}] at @s if entity @p[tag=ninja,distance=..100] run function my_pvp:roles/ninja/use_mark

# --- スキル3: 煙玉 ---
execute as @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}] at @s if entity @p[tag=ninja,distance=..100] run function my_pvp:roles/ninja/use_smoke

# --- 誤ドロップ返却システム ---
# 忍刀
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_sword"}}] at @s if entity @p[tag=ninja,distance=..100] run function my_pvp:roles/ninja/return_tool
# 変わり身
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}}] at @s if entity @p[tag=ninja,distance=..100] run function my_pvp:roles/ninja/return_tool