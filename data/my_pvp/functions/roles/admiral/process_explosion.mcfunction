# --- 1. 攻撃主(飼い主)の特定 ---
# マーカーが記憶している player_id を一時スコアにコピー
scoreboard players operation #OWNER_ID temp = @s player_id

# 全プレイヤーの中から、IDが一致する人にタグ(attacker_temp)を付ける
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# --- 2. 演出 ---
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 5 0.5
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
particle minecraft:flash ~ ~ ~ 0 0 0 0 1 force
particle minecraft:cloud ~ ~1 ~ 6 2 6 0.1 200 force
particle minecraft:lava ~ ~1 ~ 5 1 5 0.1 50 force
particle minecraft:flame ~ ~1 ~ 6 2 6 0.2 100 force
particle minecraft:campfire_signal_smoke ~ ~ ~ 7 0 7 0.1 50 force

# --- 3. ダメージ処理 (修正) ---
# instant_damage(魔法) ではなく damage(物理) を使用

# A. 飼い主が見つかった場合 (ログアウトしていなければここが動く)
# "by @p[tag=attacker_temp]" をつけることで、そのプレイヤーが攻撃した扱いになります
execute if entity @p[tag=attacker_temp] as @a[distance=..10] run damage @s 20 minecraft:explosion by @p[tag=attacker_temp,limit=1]

# B. 飼い主が見つからない場合 (ログアウト時など)
# 攻撃元なしでダメージだけ与える
execute unless entity @p[tag=attacker_temp] as @a[distance=..10] run damage @s 20 minecraft:explosion

# --- 4. 後始末 ---
tag @a remove attacker_temp
kill @s