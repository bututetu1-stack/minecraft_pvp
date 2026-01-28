# --- 1. 発射処理 (CTチェックは全削除) ---

# ID付与
tag @s add wire_arrow
# 近くのスカウトのIDを矢にコピー
scoreboard players operation @s player_id = @p[tag=scout,distance=..5] player_id

# 矢のダメージを0にする (プレイヤーに当たってもダメージ0)
data merge entity @s {damage:0.0d}

# 【削除】 CT設定
execute as @p[tag=scout,distance=..5] run scoreboard players set @s cd_wire 20

# 発射音
playsound minecraft:entity.arrow.shoot master @a ~ ~ ~ 1 2