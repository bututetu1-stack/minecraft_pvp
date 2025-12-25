# --- 1. プレイヤーの処理 ---
execute as @a[tag=mechanic] run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja] run function my_pvp:roles/ninja/ninja_main

# --- 2. アイテム検知 ---
execute as @e[type=item] at @s run function my_pvp:roles/mechanic/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/ninja/scan_items

# --- 3. ガジェットの処理 ---
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic
execute as @e[tag=gadget_hitbox] at @s run function my_pvp:roles/mechanic/gadget_tic

# --- 4. 忍者の身代わり処理 ---
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick

# --- 【追加】タレットの弾丸処理 ---
# 飛んでいる弾丸(tag=turret_shot)があれば、動かす
execute as @e[tag=turret_shot] at @s run function my_pvp:roles/mechanic/turret_shot_tick