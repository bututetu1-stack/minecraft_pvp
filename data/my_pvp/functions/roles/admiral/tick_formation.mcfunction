# === 0: 単縦陣 (Line Ahead) - 通常状態 ===
execute if score @s adm_formation matches 0 run effect give @s minecraft:strength 1 0 true

# === 1: 輪形陣 (Diamond) - 耐える ===
execute if score @s adm_formation matches 1 run effect give @s minecraft:resistance 1 0 true
execute if score @s adm_formation matches 1 run effect give @s minecraft:weakness 1 0 true

# === 2: 警戒陣 (Cruising) - 移動 ===
execute if score @s adm_formation matches 2 run effect give @s minecraft:speed 1 1 true
execute if score @s adm_formation matches 2 run effect give @s minecraft:weakness 1 1 true

# ▼▼▼ 追加: 警戒陣の被ダメージ増加 (1.5倍化) 処理 ▼▼▼

# 1. ループ防止 & 検知
# (自分で与えた追加ダメージで再度反応しないようにタグで制御)
execute if score @s damage_taken matches 1.. if entity @s[tag=ignore_damage_process] run tag @s remove ignore_damage_process
execute if score @s damage_taken matches 1.. unless entity @s[tag=ignore_damage_process] run tag @s add processing_damage

# 2. 追加ダメージ計算 (警戒陣: formation=2 の場合)
# damage_taken は「ダメージ量x10」の値 (例: ハート1個減ると 20)
# 1.5倍にするには、0.5倍分のダメージを追加する

# A. 小ダメージ (ハート0.5 ~ 2未満) -> 追加 1ダメージ (ハート0.5)
execute if entity @s[tag=processing_damage] if score @s adm_formation matches 2 if score @s damage_taken matches 10..39 run damage @s 1 minecraft:generic
# B. 中ダメージ (ハート2 ~ 4未満) -> 追加 2ダメージ (ハート1)
execute if entity @s[tag=processing_damage] if score @s adm_formation matches 2 if score @s damage_taken matches 40..79 run damage @s 2 minecraft:generic
# C. 大ダメージ (ハート4以上) -> 追加 4ダメージ (ハート2)
execute if entity @s[tag=processing_damage] if score @s adm_formation matches 2 if score @s damage_taken matches 80.. run damage @s 4 minecraft:generic

# 3. 演出 (痛そうな音)
execute if entity @s[tag=processing_damage] if score @s adm_formation matches 2 run playsound minecraft:entity.player.hurt master @s ~ ~ ~ 1 2

# 4. 後処理
# 処理完了時にループ防止タグを付与
execute if entity @s[tag=processing_damage] if score @s adm_formation matches 2 run tag @s add ignore_damage_process
# 検知タグを削除し、スコアをリセットして次の被弾に備える
tag @s remove processing_damage
execute if score @s damage_taken matches 1.. run scoreboard players set @s damage_taken 0

# ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

# --- CT消化 ---
scoreboard players remove @s[scores={cd_formation=1..}] cd_formation 1