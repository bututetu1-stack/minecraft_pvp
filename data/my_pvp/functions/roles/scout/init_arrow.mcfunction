# 1. CTチェック
# 近くのスカウト(持ち主)がCT中(1以上)の場合

# 警告をチャットに出す (アクションバーの競合回避)
execute if entity @p[tag=scout,distance=..5,scores={cd_wire=1..}] run tellraw @p[tag=scout,distance=..5] [{"text":"[System] ","color":"gray"},{"text":"スキル準備中... (Cooldown)","color":"red"}]
# クリック音
execute if entity @p[tag=scout,distance=..5,scores={cd_wire=1..}] run playsound minecraft:ui.button.click master @p[tag=scout,distance=..5] ~ ~ ~ 1 2

# 矢を消す (CT中なので撃たせない)
execute if entity @p[tag=scout,distance=..5,scores={cd_wire=1..}] run kill @s

# ▼▼▼ 重要: CT中ならここで確実に終了させる (return 0) ▼▼▼
# これがないと下の行に進んでしまい、CTがリセットされてしまいます
execute if entity @p[tag=scout,distance=..5,scores={cd_wire=1..}] run return 0
# ▲▲▲ 修正ここまで ▲▲▲


# --- 2. 発射成功時の処理 (ここに来るのはCTが0の時だけ) ---

# ID付与
tag @s add wire_arrow
scoreboard players operation @s player_id = @p[tag=scout,distance=..5] player_id

# CT設定 (5秒 = 100tick)
execute as @p[tag=scout,distance=..5] run scoreboard players set @s cd_wire 100

# 発射音
playsound minecraft:entity.arrow.shoot master @a ~ ~ ~ 1 2