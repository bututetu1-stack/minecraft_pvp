# --- 1. 旋回処理 ---
# 中心点を回転
tp @s ~ ~ ~ ~4 ~

# ファントムを公転させる
execute at @s run tp @e[tag=plane_1] ^ ^15 ^10 facing ^-10 ^15 ^10
execute at @s run tp @e[tag=plane_2] ^10 ^18 ^-5 facing ^15 ^18 ^5
execute at @s run tp @e[tag=plane_3] ^-10 ^18 ^-5 facing ^-5 ^18 ^-15


# --- 2. 共通処理 ---
# 中心点から煙
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 0 0.5 0 0.1 5 force

# タイマー処理
scoreboard players remove @s timer 1
execute if score @s timer matches 1.. run return 0

# 攻撃主(飼い主)特定
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp


# --- 3. 爆撃実行と「ガチャ」システム (1.20.1対応) ---
# 3-1. 爆弾召喚
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb","new_bomb"],Duration:5}

# 3-2. 乱数生成
scoreboard players set #CONST_10 temp 10
execute as @e[tag=new_bomb] store result score @s temp run data get entity @s UUID[0]
execute as @e[tag=new_bomb] run scoreboard players operation @s temp %= #CONST_10 temp
execute as @e[tag=new_bomb] if score @s temp matches ..-1 run scoreboard players add @s temp 10
execute as @e[tag=new_bomb] run scoreboard players add @s temp 1


# 3-3. 機体名と性能の付与
# 彗星 (1~6)
execute as @e[tag=new_bomb] if score @s temp matches 1..6 run tag @s add type_suisei
execute as @e[tag=new_bomb] if score @s temp matches 1..6 run data modify entity @s CustomName set value '{"text":"彗星一二型甲","color":"red","bold":true}'
# 烈風 (7~9)
execute as @e[tag=new_bomb] if score @s temp matches 7..9 run tag @s add type_reppu
execute as @e[tag=new_bomb] if score @s temp matches 7..9 run data modify entity @s CustomName set value '{"text":"烈風改","color":"green","bold":true}'
# 流星 (10)
execute as @e[tag=new_bomb] if score @s temp matches 10 run tag @s add type_ryusei
execute as @e[tag=new_bomb] if score @s temp matches 10 run data modify entity @s CustomName set value '{"text":"流星改","color":"blue","bold":true}'


# 3-4. 拡散 (艦種による範囲分岐)
execute if entity @s[tag=type_kaga] run spreadplayers ~ ~ 0 30 false @e[tag=new_bomb]
execute if entity @s[tag=type_zuikaku] run spreadplayers ~ ~ 0 25 false @e[tag=new_bomb]
execute if entity @s[tag=type_zuiho] run spreadplayers ~ ~ 0 20 false @e[tag=new_bomb]

tag @e[tag=new_bomb] remove new_bomb


# --- 4. 演出 ---
execute at @e[tag=adm_bomb] run particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
execute at @e[tag=adm_bomb] run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1


# --- 5. ダメージ処理 (手動判定方式) ---

execute at @e[tag=adm_bomb] run summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# Ownerコピーは削除 (二重計上防止)
# execute if entity @p[tag=attacker_temp] at @e[tag=adm_bomb] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] Owner set from entity @p[tag=attacker_temp,limit=1] UUID

# 名前コピー (爆弾本体からプロキシへ)
execute at @e[tag=adm_bomb] run data modify entity @e[tag=dmg_proxy,limit=1,sort=nearest] CustomName set from entity @e[tag=adm_bomb,limit=1,sort=nearest] CustomName

# === A. 彗星 ===
# 1. 記録
execute as @e[tag=adm_bomb,tag=type_suisei] at @s as @a[distance=..5] run scoreboard players operation @s temp = @s deaths
# 2. ダメージ
execute as @e[tag=adm_bomb,tag=type_suisei] at @s as @a[distance=..5] run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
# 3. 判定
execute as @e[tag=adm_bomb,tag=type_suisei] at @s as @a[distance=..5] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === B. 烈風 ===
execute as @e[tag=adm_bomb,tag=type_reppu] at @s as @a[distance=..8] run scoreboard players operation @s temp = @s deaths
execute as @e[tag=adm_bomb,tag=type_reppu] at @s as @a[distance=..8] run damage @s 6 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute as @e[tag=adm_bomb,tag=type_reppu] at @s as @a[distance=..8] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# === C. 流星 ===
execute as @e[tag=adm_bomb,tag=type_ryusei] at @s as @a[distance=..4] run scoreboard players operation @s temp = @s deaths
execute as @e[tag=adm_bomb,tag=type_ryusei] at @s as @a[distance=..4] run damage @s 15 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,sort=nearest] from @e[tag=dmg_proxy,limit=1,sort=nearest]
execute as @e[tag=adm_bomb,tag=type_ryusei] at @s as @a[distance=..4] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1


# --- 6. 後始末 ---
kill @e[tag=dmg_proxy]
kill @e[tag=adm_bomb]
tag @a remove attacker_temp

# 次のサイクルへ
scoreboard players remove @s ammo 1
scoreboard players set @s timer 5

# 終了判定
execute unless score @s ammo matches 1.. run kill @e[tag=adm_plane]
execute unless score @s ammo matches 1.. run kill @s