# 凍結中は処理をスキップ
execute if entity @s[tag=is_frozen] run return 0

# --- タレット (Sentry) ---
# startup判定を削除し、常に攻撃処理を行うように戻しました
execute if entity @s[tag=sentry] run function my_pvp:roles/mechanic/sentry_attack


# --- 地雷 (Mine) ---
execute if entity @s[tag=mine] run function my_pvp:roles/mechanic/mine_explode

# --- ランチャー (Launcher) ---
execute if entity @s[tag=launcher] run function my_pvp:roles/mechanic/launcher_trigger

# --- 重力スネア (Snare) ---
execute if entity @s[tag=snare] run function my_pvp:roles/mechanic/snare_tick

# --- レンチ操作検知 ---
execute if entity @s[tag=gadget_hitbox] if data entity @s interaction run function my_pvp:roles/mechanic/wrench_click
execute if entity @s[tag=gadget_hitbox] if data entity @s attack run function my_pvp:roles/mechanic/hitbox_attack