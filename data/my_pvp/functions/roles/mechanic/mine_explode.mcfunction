# 1. 念のため開始時にタグ掃除
tag @a remove stepping_enemy
tag @a remove owner_temp

# 2. 踏んだプレイヤーを検知
scoreboard players operation #TEMP player_id = @s player_id

# 判定位置を「足元」から「少し上」にして、ジャンプ等でのすり抜けを防止
# スペクテイターは除外
execute at @s positioned ~ ~1 ~ as @a[distance=..2.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add stepping_enemy

# 誰も踏んでいなければ終了
execute unless entity @a[tag=stepping_enemy] run return 0

# --- 以下、起爆処理 ---

# 3. 演出
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 4. 所有者の特定
execute as @a if score @s player_id = #TEMP player_id run tag @s add owner_temp

# 5. ダメージ処理
# パターンA: 所有者がいる (キルログが正常に出る)
execute if entity @a[tag=owner_temp] as @a[tag=stepping_enemy] run damage @s 8 minecraft:explosion by @p[tag=owner_temp]
execute if entity @a[tag=owner_temp] as @a[distance=2.01..5,gamemode=!spectator] run damage @s 4 minecraft:explosion by @p[tag=owner_temp]

# パターンB: 所有者がいない/見つからない (ログアウト等) -> ダメージ源なしで強制ダメージ
execute unless entity @a[tag=owner_temp] as @a[tag=stepping_enemy] run damage @s 8 minecraft:explosion
execute unless entity @a[tag=owner_temp] as @a[distance=2.01..5,gamemode=!spectator] run damage @s 4 minecraft:explosion

# 6. 本体消去
kill @s