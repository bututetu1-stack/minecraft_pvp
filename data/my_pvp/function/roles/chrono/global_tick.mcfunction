# ==========================================
# ▼▼▼ 時空跳躍者: グローバル常時処理 ▼▼▼
# ==========================================

# --- A. 静止フィールド(stasis_center)を中心に凍結判定 ---
execute at @e[tag=stasis_center] run tag @a[distance=..20,tag=!chrono] add is_frozen
execute at @e[tag=stasis_center] run scoreboard players set @a[distance=..20,tag=!chrono] freeze_timer 2
# 【修正】自分自身(stasis_center)は除外する
execute at @e[tag=stasis_center] run tag @e[type=!player,distance=..20,tag=!stasis_center,tag=!chrono_marker] add is_frozen
execute at @e[tag=stasis_center] run scoreboard players set @e[type=!player,distance=..20,tag=!stasis_center,tag=!chrono_marker] freeze_timer 2

# --- B. ドーム描画 (フィールド中心で) ---
execute as @e[tag=stasis_center] at @s run function my_pvp:roles/chrono/draw_dome

# --- C. 発動タイマー管理 ---
# area_effect_cloud の Duration で自動消滅するので、ここでのカウントは不要

# --- D. 凍結タイマー減少 & 解除 ---
execute as @e[scores={freeze_timer=1..}] run scoreboard players remove @s freeze_timer 1
execute as @e[scores={freeze_timer=0},tag=is_frozen] run tag @s remove is_frozen

# --- E. 凍結中の挙動 (アンカー方式) ---

# 1. 新規凍結: アンカー作成
execute as @a[tag=is_frozen,tag=!has_anchor] at @s run function my_pvp:roles/chrono/freeze_start

# 2. 継続処理: アンカー位置へTP
execute as @a[tag=is_frozen,tag=has_anchor] run function my_pvp:roles/chrono/freeze_tick

# 3. 凍結終了: アンカー削除
execute as @a[tag=!is_frozen,tag=has_anchor] run function my_pvp:roles/chrono/freeze_end

# --- F. プレイヤー以外の固定 ---
execute as @e[type=!player,tag=is_frozen] run data merge entity @s {Motion:[0.0d,0.0d,0.0d]}
execute as @e[type=!player,tag=is_frozen] at @s run tp @s ~ ~ ~