# === 0: 単縦陣 (Line Ahead) ===
execute if score @s adm_formation matches 0 run effect give @s minecraft:strength 1 0 true

# === 1: 輪形陣 (Diamond) ===
execute if score @s adm_formation matches 1 run effect give @s minecraft:resistance 1 0 true
execute if score @s adm_formation matches 1 run effect give @s minecraft:weakness 1 0 true

# === 2: 警戒陣 (Cruising) ===
execute if score @s adm_formation matches 2 run effect give @s minecraft:speed 1 1 true
execute if score @s adm_formation matches 2 run effect give @s minecraft:weakness 1 1 true


# ▼▼▼ 警戒陣の被ダメージ増加 (共通システム連携版) ▼▼▼

# A. 自己ループ防止
# 共通システムから受けたダメージ(ignore_penalty_loop付き)なら、スコアを消して終了
execute if score @s damage_taken matches 1.. if entity @s[tag=ignore_penalty_loop] run scoreboard players set @s damage_taken 0
tag @s remove ignore_penalty_loop

# B. ペナルティ予約 (敵の攻撃を検知)
# 警戒陣(2) で、かつスコアが残っているなら処理開始
execute if score @s adm_formation matches 2 if score @s damage_taken matches 1.. run tag @s add calc_penalty

# C. ダメージ量セット
execute if entity @s[tag=calc_penalty] if score @s damage_taken matches 1..39 run scoreboard players set @s penalty_dmg 1
execute if entity @s[tag=calc_penalty] if score @s damage_taken matches 40..79 run scoreboard players set @s penalty_dmg 2
execute if entity @s[tag=calc_penalty] if score @s damage_taken matches 80.. run scoreboard players set @s penalty_dmg 4

# D. タイマーセット (12tick後に共通システムが処理)
execute if entity @s[tag=calc_penalty] run scoreboard players set @s penalty_timer 12

# 後始末
tag @s remove calc_penalty

# --- CT消化 ---
scoreboard players remove @s[scores={cd_formation=1..}] cd_formation 1

# ▼▼▼ 【重要】ダメージスコアのリセット ▼▼▼
# 警戒陣以外のときや、処理されなかった古いダメージスコアをここで必ず消去する
scoreboard players set @s damage_taken 0