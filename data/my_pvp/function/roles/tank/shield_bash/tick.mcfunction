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
particle minecraft:cloud ~ ~0.5 ~ 0.2 0.2 0.2 0.05 3

# Decrement
scoreboard players remove @s shield_dash_timer 1
tag @s remove dasher_processing
