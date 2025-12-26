# 1. CTチェック
execute if score @s cooldown matches 1.. run scoreboard players remove @s cooldown 1
execute if score @s cooldown matches 1.. run return 0

# 2. ターゲット選定 (対プレイヤー)
# 念のため開始時に全解除
tag @a remove sentry_target
tag @a remove potential_target

# 自身のIDを取得
scoreboard players operation #TEMP player_id = @s player_id

# 範囲内のプレイヤー(スペクテイター除く)を候補にする
tag @a[distance=..15,gamemode=!spectator] add potential_target

# 所有者(自分と同じIDを持つプレイヤー)を候補から除外
execute as @a[tag=potential_target] if score @s player_id = #TEMP player_id run tag @s remove potential_target

# 最寄りの候補を1人選択
tag @a[tag=potential_target,sort=nearest,limit=1] add sentry_target

# ターゲットがいなければ終了
execute unless entity @a[tag=sentry_target] run return 0

# 3. 発射処理
# タレット本体を敵に向ける
execute at @s run tp @s ~ ~ ~ facing entity @a[tag=sentry_target,limit=1] eyes

# 効果音
playsound minecraft:entity.arrow.shoot master @a ~ ~ ~ 1 1.5

# --- 弾丸の生成 (透明マーカー) ---
execute at @s run summon marker ^ ^1.5 ^1.2 {Tags:["turret_shot"]}

# 弾丸をターゲットに向ける
execute as @e[tag=turret_shot,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ facing entity @a[tag=sentry_target,limit=1] eyes

# IDのコピー (ダメージ判定用)
execute as @e[tag=turret_shot,limit=1,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id

# 4. 後始末
tag @a remove sentry_target
tag @a remove potential_target

# CT再設定
scoreboard players set @s cooldown 20