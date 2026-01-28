# トレイルの処理 (パーティクル表示 & 寿命)
# @s = Marker
# 呼び出し元で Stalkerを特定タグ(@a[tag=current_stalker])付けしている前提

# --- 1. パーティクル表示 (Visuals - Always Run) ---
# #TEMP player_id には ストーカーが追ってるターゲットID が入っている
execute if score @s target_id = #TEMP player_id at @s run particle dust{color:[1.0,0.0,0.0],scale:1.0} ~ ~0.2 ~ 0 0 0 0 1 force @a[tag=current_stalker]

# --- 2. 凍結チェック (Frozen Check) ---
execute if entity @s[tag=is_frozen] run return 0

# --- 3. ロジック (Logic) ---
# 寿命減少
scoreboard players remove @s gadget_life 1
execute if score @s gadget_life matches ..0 run kill @s
