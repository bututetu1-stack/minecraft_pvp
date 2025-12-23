# 1. ターゲット選定
tag @a remove sentry_target
# 範囲10マス以内のプレイヤーを候補にする
execute at @s as @a[distance=..10] run tag @s add sentry_scan_candidate

# 設置者(自分)はターゲットから除外
execute at @s as @a[tag=sentry_scan_candidate] if score @s player_id = @e[tag=sentry,distance=..0.1,limit=1] player_id run tag @s remove sentry_scan_candidate

# 残った候補の中で、一番近い1人をターゲットにする
execute at @s as @p[tag=sentry_scan_candidate] run tag @s add sentry_target


# 2. 攻撃実行（ターゲットがいる場合のみ）

# --- 演出 ---
# 【修正】faceコマンドではなく、tpコマンドのfacing機能を使って向きを変えます
execute if entity @p[tag=sentry_target] run tp @s ~ ~ ~ facing entity @p[tag=sentry_target] eyes

execute if entity @p[tag=sentry_target] run playsound minecraft:entity.iron_golem.damage master @a ~ ~ ~ 1 2.0
execute if entity @p[tag=sentry_target] run particle minecraft:crit ~ ~1.5 ~ 0.2 0.2 0.2 0.5 10
execute if entity @p[tag=sentry_target] at @p[tag=sentry_target] run particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1

# --- ダメージ処理（持ち主判定） ---
# 今攻撃しようとしているタレットに目印タグをつける
tag @s add current_shooter

# 「IDが一致するプレイヤー(@s)」として実行し、ターゲットにダメージを与える
execute if entity @p[tag=sentry_target] as @a if score @s player_id = @e[tag=current_shooter,limit=1] player_id run damage @p[tag=sentry_target] 4 minecraft:arrow by @s

# 目印タグを消す
tag @s remove current_shooter

# --- クールダウン設定 (15tick = 0.75秒) ---
execute if entity @p[tag=sentry_target] as @e[tag=sentry,distance=..0.1,limit=1] run scoreboard players set @s cooldown 15


# 3. 後始末
tag @a remove sentry_scan_candidate
tag @a remove sentry_target