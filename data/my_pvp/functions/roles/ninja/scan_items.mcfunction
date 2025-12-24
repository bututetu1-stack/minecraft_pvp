# --- スキル1: 影縫い (設置) ---
execute as @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}] at @s if entity @p[tag=ninja,distance=..300] run function my_pvp:roles/ninja/use_mark

# --- スキル3: 煙玉 ---
execute as @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}] at @s if entity @p[tag=ninja,distance=..300] run function my_pvp:roles/ninja/use_smoke