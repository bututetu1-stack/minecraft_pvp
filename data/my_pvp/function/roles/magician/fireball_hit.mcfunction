# 炎玉ヒット処理

# 1. ダメージを与える (ハート3個分 = 6HP)
# 対象プレイヤーをマーク
execute at @s run tag @a[distance=..1.5,limit=1,sort=nearest] add mag_victim

# 攻撃者(owner)の特定用: 既存の owner_temp を一旦クリアし、弾の player_id を用いて owner にタグを付ける
tag @a remove owner_temp
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=magician] if score @s player_id = #TEMP player_id run tag @s add owner_temp

# ダメージ実行 (攻撃者指定はしていないが、キル判定は下で実施)
execute at @s run damage @a[distance=..1.5,limit=1,sort=nearest] 6 minecraft:magic

# 2. ヒットエフェクト
particle minecraft:flame ~ ~1 ~ 0.3 0.3 0.3 0.1 20
execute at @s run playsound minecraft:entity.blaze.hurt master @a[distance=..1.5,limit=1,sort=nearest] ~ ~ ~ 1 1

# 3. 炎玉を消す
kill @s

# --- キル判定と攻撃者へのキル付与/報酬 ---
# 対象のHPを取得し、死んでいれば owner に kills を加算し、死体処理タグを付与
execute as @a[tag=mag_victim,tag=!dead_processing] store result score #TARGET_HP temp run data get entity @s Health 100
execute as @a[tag=mag_victim,tag=!dead_processing] if score #TARGET_HP temp matches ..0 as @p[tag=owner_temp,limit=1] run scoreboard players add @s kills 1
execute as @a[tag=mag_victim,tag=!dead_processing] if score #TARGET_HP temp matches ..0 as @p[tag=owner_temp,limit=1] run scoreboard players add @s mana 30
execute as @a[tag=mag_victim] if score #TARGET_HP temp matches ..0 run tag @s add dead_processing

# 片付け
tag @a remove mag_victim
tag @a remove owner_temp
