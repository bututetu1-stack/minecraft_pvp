# 1. 設置主の特定
# 地雷(@s)のIDを一時スコアにコピー
scoreboard players operation #TEMP player_id = @s player_id

# 一旦全員からタグを外し、IDが一致するプレイヤー(持ち主)にタグを付ける
tag @a remove mine_owner
execute as @a if score @s player_id = #TEMP player_id run tag @s add mine_owner

# 自分（地雷）に目印をつける
tag @s add exploding_mine

# 2. ダメージ処理
# エラー回避のため、範囲内のプレイヤー(@a)を1人ずつ(@s)実行者にしてダメージを与えます
# 「by @a[tag=mine_owner,limit=1]」で、攻撃者を持ち主に指定します

# --- 近距離 (～2m): 6ダメージ ---
execute as @a[tag=mine_owner] at @e[tag=exploding_mine] as @a[distance=..2] run damage @s 6 minecraft:explosion by @a[tag=mine_owner,limit=1]

# --- 遠距離 (2m～5m): 3ダメージ ---
execute as @a[tag=mine_owner] at @e[tag=exploding_mine] as @a[distance=2.01..5] run damage @s 3 minecraft:explosion by @a[tag=mine_owner,limit=1]

# 3. 演出
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 4. 後始末
kill @s