# 1. 前進 (tp ^ ^ ^ で直進)
tp @s ^ ^ ^0.8

# 2. 演出パーティクル
particle minecraft:crit ~ ~ ~ 0 0 0 0 1
particle minecraft:electric_spark ~ ~ ~ 0 0 0 0 1

# 3. 寿命・衝突判定
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 60.. run kill @s

# 壁衝突
execute unless block ~ ~ ~ air unless block ~ ~ ~ light unless block ~ ~ ~ water run kill @s

# 4. ヒット判定 (対プレイヤー)
tag @a remove shot_hit
# プレイヤーの「胴体中心(Y+1)」からの距離で判定 (スペクテイターは無視)
execute as @a[gamemode=!spectator] at @s positioned ~ ~1 ~ if entity @e[tag=turret_shot,distance=..1.5,limit=1] run tag @s add shot_hit

# 所有者(自分と同じID)への誤射防止
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=shot_hit] if score @s player_id = #TEMP player_id run tag @s remove shot_hit

# ヒットしていなければ終了
execute unless entity @a[tag=shot_hit] run return 0

# 5. ダメージ処理 & ポイント加算
# 持ち主のプレイヤーを特定 (ポイント加算用)
tag @a remove current_owner
execute as @a if score @s player_id = #TEMP player_id run tag @s add current_owner

# ダメージ実行 (byを使わず at @s で保護貫通)
execute as @a[tag=shot_hit,limit=1] run damage @s 2 minecraft:generic at ~ ~ ~

# --- 【追加】無敵時間のリセット ---
# ダメージを与えた直後に無敵時間を0にすることで、
# 同時に他のタレットから攻撃されてもダメージが入るようにします
execute as @a[tag=shot_hit,limit=1] run data merge entity @s {HurtTime:0s}


# --- キル判定とポイント付与 (二重加算防止) ---
# ダメージ後のHPを確認 (dead_processingタグがない人のみ)
execute as @a[tag=shot_hit,tag=!dead_processing] store result score #TARGET_HP temp run data get entity @s Health 100

# HPが0以下なら、所有者のキル数を+1する
execute as @a[tag=shot_hit,tag=!dead_processing] if score #TARGET_HP temp matches ..0 as @p[tag=current_owner] run scoreboard players add @s kills 1

# 加算済みタグを付与
execute as @a[tag=shot_hit] if score #TARGET_HP temp matches ..0 run tag @s add dead_processing

# 命中したら弾丸を消去
kill @s