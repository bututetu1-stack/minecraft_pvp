# --- 1. プレイヤーの処理 ---
# at @s を入れて、自身の位置を基準にする
execute as @a[tag=mechanic] at @s run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja] at @s run function my_pvp:roles/ninja/ninja_main
execute as @a[tag=scout] at @s run function my_pvp:roles/scout/scout_main

# --- 2. アイテム処理（常時監視） ---
# 機械工: アイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/mechanic/scan_items

# 忍者: アイテムスキャン 
execute as @e[type=item] at @s run function my_pvp:roles/ninja/scan_items

# スカウト: アイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/scout/scan_items

# --- 3. ガジェットの処理 ---
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic
execute as @e[tag=gadget_hitbox] at @s run function my_pvp:roles/mechanic/gadget_tic

# --- 4. 忍者の身代わり処理 ---
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick

# --- 5. タレットの弾丸処理 ---
execute as @e[tag=turret_shot] at @s run function my_pvp:roles/mechanic/turret_shot_tick