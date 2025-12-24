# --- 機械工 ---
execute as @a[tag=mechanic] run function my_pvp:roles/mechanic/mechanic_main
function my_pvp:roles/mechanic/scan_items
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic

# --- 【追加】忍者 ---
execute as @a[tag=ninja] run function my_pvp:roles/ninja/ninja_main
function my_pvp:roles/ninja/scan_items

# 【追加】身代わりの被ダメージ検知
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick