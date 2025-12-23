# --- 赤石トーチ（タレット） ---
# 距離制限を 300 に拡大
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"},OnGround:1b}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_torch

# --- 鉄トラップドア（地雷） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"},OnGround:1b}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_mine

# --- ピストン（ランチャー） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:piston"},OnGround:1b}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_launcher