# --- 1. プレイヤーの処理 ---
# at @s を入れて、自身の位置を基準にする
execute as @a[tag=mechanic] at @s run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja] at @s run function my_pvp:roles/ninja/ninja_main
execute as @a[tag=scout] at @s run function my_pvp:roles/scout/scout_main
execute as @a[tag=tank] at @s run function my_pvp:roles/tank/tank_main

# --- 【修正】ゆっくり自動回復 (Slow Regen) ---
# ピースフル設定のため満腹度は減りません。チェックを廃止して軽量化しました。

# 1. カウントアップ（生存者のみ）
execute as @a[gamemode=!spectator] run scoreboard players add @s regen_timer 1

# 2. 回復実行 (5秒ごとに0.5ハート回復)
execute as @a[scores={regen_timer=100..}] run effect give @s minecraft:regeneration 3 0 true
execute as @a[scores={regen_timer=100..}] run scoreboard players set @s regen_timer 0


# --- 2. アイテム処理（常時監視） ---
execute as @e[type=item] at @s run function my_pvp:roles/mechanic/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/ninja/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/scout/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/tank/scan_items

# --- 3. ガジェットの処理 ---
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic
execute as @e[tag=gadget_hitbox] at @s run function my_pvp:roles/mechanic/gadget_tic

# --- 4. 忍者の身代わり処理 ---
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick

# --- 5. タレットの弾丸処理 ---
execute as @e[tag=turret_shot] at @s run function my_pvp:roles/mechanic/turret_shot_tick