# 1. CTチェック
execute if score @s cooldown matches 1.. run scoreboard players remove @s cooldown 1
execute if score @s cooldown matches 1.. run return 0

# 2. ターゲット選定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove sentry_target

execute as @a[distance=..15] unless score @s player_id = #TEMP player_id run tag @s add sentry_target_candidate
tag @a[tag=sentry_target_candidate,sort=nearest,limit=1] add sentry_target
tag @a remove sentry_target_candidate

# ターゲット不在なら終了
execute unless entity @a[tag=sentry_target] run return 0

# 3. 発射処理
# タレットを敵の方に向ける
execute at @s run tp @s ~ ~ ~ facing entity @p[tag=sentry_target] eyes

# 発射音
playsound minecraft:entity.arrow.shoot master @a ~ ~ ~ 1 1.5

# --- 【変更】弾丸(矢)の生成 ---
# 1. 矢を召喚 (NoGravity:1b で重力無視、pickup:0b で拾えない)
summon arrow ~ ~1.5 ~ {Tags:["turret_shot"],NoGravity:1b,pickup:0b,damage:0.0d,life:0}

# 2. 矢の持ち主IDを設定 (キルログ用)
execute as @e[tag=turret_shot,limit=1,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id

# 3. 矢の向きをタレットと同じにする
data modify entity @e[tag=turret_shot,limit=1,sort=nearest] Rotation set from entity @s Rotation

# 4. CT再設定 (少し短くしてもいいかもしれません)
scoreboard players set @s cooldown 20