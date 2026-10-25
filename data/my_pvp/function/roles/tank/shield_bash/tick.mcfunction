# Shield Bash Tick
# @s = player

# Timer check
execute if score @s shield_dash_timer matches ..0 run function my_pvp:roles/tank/shield_bash/end
execute if score @s shield_dash_timer matches ..0 run return 0

# ユーザーID取得
tag @s add dasher_processing
scoreboard players operation #TEMP player_id = @s player_id

# 1. Guide Movement
# 壁判定: 前方が空気(air/void/cave)でなければ停止処理 (end関数を呼び出し、マーカー削除とタグ解除を行う)
execute as @e[tag=bash_guide] if score @s player_id = #TEMP player_id at @s unless block ^ ^ ^1 #minecraft:air as @p[tag=dasher_processing] run function my_pvp:roles/tank/shield_bash/end
# 壁に当たって終了した場合は、このtickの残り処理をしない
execute unless score @s shield_dash_timer matches 1.. run return run tag @s remove dasher_processing
# マーカーを前進させる (Speed 1.0 block/tick)
execute as @e[tag=bash_guide] if score @s player_id = #TEMP player_id at @s run tp @s ^ ^ ^1.0

# 2. Player Movement (Lock Direction)
# プレイヤーをマーカーの位置・向きに強制移動
execute as @e[tag=bash_guide] if score @s player_id = #TEMP player_id at @s run tp @p[tag=dasher_processing] ~ ~ ~ ~ ~

# 3. Collision / Knockback
# 近くの敵にダメージとノックバック (1回のダッシュにつき1回のみ)
execute as @a[tag=!dasher_processing,tag=!bashed_temp,distance=..2.5] at @s run damage @s 8 minecraft:player_attack by @p[tag=dasher_processing]
execute as @a[tag=!dasher_processing,tag=!bashed_temp,distance=..2.5] at @s run particle minecraft:explosion ~ ~1 ~ 0.5 0.5 0.5 0.1 5
execute as @a[tag=!dasher_processing,tag=!bashed_temp,distance=..2.5] at @s run tag @s add bashed_temp

# Effect
# ズゴゴゴゴ！ (土煙と衝撃)
particle minecraft:cloud ~ ~0.5 ~ 0.5 0.2 0.5 0.05 5
particle minecraft:block{block_state:{Name:"minecraft:dirt"}} ~ ~0.1 ~ 0.5 0.1 0.5 1 10
particle minecraft:campfire_signal_smoke ~ ~0.2 ~ 0.2 0.2 0.2 0.08 3

# 効果音 (重低音)
playsound minecraft:entity.iron_golem.step master @a ~ ~ ~ 1 0.5
playsound minecraft:block.gravel.break master @a ~ ~ ~ 1 0.5

# Decrement
scoreboard players remove @s shield_dash_timer 1
tag @s remove dasher_processing

# 時間切れの終了処理
# (tank_main は timer が 1 以上の時しかこの関数を呼ばないため、0 になった瞬間にここで終了させる)
execute if score @s shield_dash_timer matches ..0 run function my_pvp:roles/tank/shield_bash/end
