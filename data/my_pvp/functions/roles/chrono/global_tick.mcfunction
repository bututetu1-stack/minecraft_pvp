# ==========================================
# ▼▼▼ 時空跳躍者: グローバル常時処理 ▼▼▼
# ==========================================

# --- A. フィールドによる継続凍結付与 (ドームに入った人を捕まえる) ---
# マーカー(stasis_center)の周囲20mにいる対象にタグ付与 & タイマー維持(2tick)
execute at @e[tag=stasis_center] run tag @a[distance=..20,tag=!chrono] add is_frozen
execute at @e[tag=stasis_center] run scoreboard players set @a[distance=..20,tag=!chrono] freeze_timer 2

execute at @e[tag=stasis_center] run tag @e[type=!player,distance=..20] add is_frozen
execute at @e[tag=stasis_center] run scoreboard players set @e[type=!player,distance=..20] freeze_timer 2

# --- B. ドームエフェクトの描画 ---
# マーカーが存在する間、専用の描画関数を呼び出してリングを表示
execute as @e[tag=stasis_center] at @s run function my_pvp:roles/chrono/draw_dome

# --- C. 凍結の解除処理 ---
# 1. タイマー消化 (フィールド外に出た、またはフィールドが消滅した場合に減り始める)
execute as @e[scores={freeze_timer=1..}] run scoreboard players remove @s freeze_timer 1

# 2. 解除 (0になったらタグを消す)
execute as @e[scores={freeze_timer=0},tag=is_frozen] run tag @s remove is_frozen

# --- D. 凍結中の挙動 (タグがある間) ---

# 1. プレイヤー: 移動不可 (鈍足 & ジャンプ不可)
execute as @a[tag=is_frozen] run effect give @s minecraft:slowness 1 255 true
execute as @a[tag=is_frozen] run effect give @s minecraft:jump_boost 1 255 true
execute as @a[tag=is_frozen] run title @s actionbar {"text":"|| 時間停止中 ||","color":"aqua"}
# 氷のエフェクト
execute as @a[tag=is_frozen] at @s run particle minecraft:snowflake ~ ~1 ~ 0.5 1 0.5 0.05 5 force

# 2. 物理型・飛び道具 (矢、トライデントなど) : その場に固定
execute as @e[type=arrow,tag=is_frozen] run tp @s ~ ~ ~
execute as @e[type=trident,tag=is_frozen] run tp @s ~ ~ ~