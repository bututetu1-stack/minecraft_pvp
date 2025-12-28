# 1. 念のため開始時にタグ掃除
tag @a remove stepping_enemy
tag @a remove owner_temp

# 2. 踏んだプレイヤーを検知
scoreboard players operation #TEMP player_id = @s player_id

# 判定位置補正
execute at @s positioned ~ ~1 ~ as @a[distance=..2.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add stepping_enemy

# 誰も踏んでいなければ終了
execute unless entity @a[tag=stepping_enemy] run return 0

# --- 以下、起爆処理 ---

# 3. 演出
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 4. 所有者の特定
execute as @a if score @s player_id = #TEMP player_id run tag @s add owner_temp

# --- 5. ダメージ処理 (修正版) ---

# ダメージを受ける対象をタグ付け
tag @a remove mine_victim
execute at @s positioned ~ ~1 ~ as @a[tag=stepping_enemy] run tag @s add mine_victim
execute at @s positioned ~ ~1 ~ as @a[distance=2.01..5,gamemode=!spectator] run tag @s add mine_victim

# 【修正】攻撃者(owner_temp)を指定してダメージを与える
# これにより標準のキルログとキルカウントが機能します
execute as @a[tag=mine_victim] run damage @s 8 minecraft:explosion by @p[tag=owner_temp,limit=1]

# 爆風ダメージ (4)
# 距離判定で除外したいが、簡易的に victim かつ stepping_enemy でない人に適用
execute as @a[tag=mine_victim,tag=!stepping_enemy] run damage @s 4 minecraft:explosion by @p[tag=owner_temp,limit=1]


# 【修正】手動ポイント加算を無効化
# by指定により標準機能でカウントされるため、重複を防ぐためにコメントアウトします。
# もしポイントが入らない場合は、ここを戻してください。
# execute as @a[tag=mine_victim,tag=!dead_processing] store result score #TARGET_HP temp run data get entity @s Health 100
# execute as @a[tag=mine_victim,tag=!dead_processing] if score #TARGET_HP temp matches ..0 as @p[tag=owner_temp,limit=1] run scoreboard players add @s kills 1
# execute as @a[tag=mine_victim] if score #TARGET_HP temp matches ..0 run tag @s add dead_processing

# 6. 本体消去
kill @s