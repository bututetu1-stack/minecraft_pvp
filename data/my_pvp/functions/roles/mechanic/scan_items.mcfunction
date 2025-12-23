# --- 赤石トーチ（タレット） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:redstone_torch"}}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_torch

# --- 鉄トラップドア（地雷） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_trapdoor"}}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_mine

# --- ピストン（ランチャー） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:piston"}}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_launcher

# --- 【追加】コンパス（重力スネア） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:compass"}}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_snare

# --- 鉄の斧（レンチ） ---
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_axe"}}] at @s if entity @p[tag=mechanic,distance=..300] run function my_pvp:roles/mechanic/process_wrench