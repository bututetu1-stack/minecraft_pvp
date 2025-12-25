# 1. 前進
tp @s ^ ^ ^0.8

# 2. パーティクル演出
particle minecraft:crit ~ ~ ~ 0 0 0 0 1

# 3. 寿命設定
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 60.. run kill @s

# --- 4. 命中判定 ---
scoreboard players operation #TEMP player_id = @s player_id

# 4-A. 壁に当たったら消滅
execute unless block ~ ~ ~ air unless block ~ ~ ~ light unless block ~ ~ ~ water run kill @s

# 4-B. プレイヤーにヒット
tag @a remove shot_hit
execute as @a[distance=..1.5] unless score @s player_id = #TEMP player_id run tag @s add shot_hit

# ヒット時の処理
# ダメージを与える (ダメージ元を特定するため、一度持ち主を探す)
tag @a remove owner_temp
execute as @a if score @s player_id = #TEMP player_id run tag @s add owner_temp

# 自分のタグをつけておく（from指定用）
tag @s add current_shot

# --- 【修正】ダメージ処理 ---
# 画像のエラー原因だった "amount:" を削除し、正しい構文に修正しました

# 所有者がいる場合: by 所有者 from 弾丸
execute if entity @a[tag=shot_hit] if entity @a[tag=owner_temp] as @a[tag=shot_hit] run damage @s 4 minecraft:arrow by @p[tag=owner_temp] from @e[tag=current_shot,limit=1]

# 所有者が不在の場合: from 弾丸 (byは指定しない)
execute if entity @a[tag=shot_hit] unless entity @a[tag=owner_temp] as @a[tag=shot_hit] run damage @s 4 minecraft:arrow by @e[tag=current_shot,limit=1]

# ヒットしたら矢を消す
execute if entity @a[tag=shot_hit] run kill @s