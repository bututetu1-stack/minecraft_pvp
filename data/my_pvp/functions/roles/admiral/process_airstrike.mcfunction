# --- 旋回処理 (修正版) ---
# 1. 中心点を回転させる (ヨー軸を回す)
tp @s ~ ~ ~ ~4 ~

# 2. ファントムを公転させる
# "facing" の座標を工夫して、常に円の接線方向(進行方向)を向かせます
# ※ ^-10 ^15 ^10 のような数値は、現在位置から進行方向ベクトルを足した地点です

# 親機 (plane_1): 位置[^ ^15 ^10] -> 進行方向向き
execute at @s run tp @e[tag=plane_1] ^ ^15 ^10 facing ^-10 ^15 ^10

# 僚機 (plane_2): 位置[^10 ^18 ^-5] (左側) -> 進行方向向き
execute at @s run tp @e[tag=plane_2] ^10 ^18 ^-5 facing ^15 ^18 ^5

# 僚機 (plane_3): 位置^-10 ^18 ^-5] (右側) -> 進行方向向き
execute at @s run tp @e[tag=plane_3] ^-10 ^18 ^-5 facing ^-5 ^18 ^-15

# --------------------------
# 以下、既存の処理
# --------------------------

# 中心点から煙 (目印)
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 0 0.5 0 0.1 5 force

# タイマー処理
scoreboard players remove @s timer 1
execute if score @s timer matches 1.. run return 0

# --- 攻撃主特定 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# --- 爆撃実行 ---
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb"],Duration:5}
spreadplayers ~ ~ 0 20 false @e[tag=adm_bomb]

# 演出
execute at @e[tag=adm_bomb] run particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
execute at @e[tag=adm_bomb] run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1

# --- ダメージ処理 ---
execute at @e[tag=adm_bomb] run summon armor_stand ~ ~ ~ {Tags:["dmg_proxy"],CustomName:'{"text":"航空支援","color":"gold","bold":true}',Invisible:1b,Marker:1b,NoGravity:1b}
execute at @e[tag=adm_bomb] as @a[distance=..5] run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,distance=..1]
kill @e[tag=dmg_proxy]

# --- 後始末 ---
kill @e[tag=adm_bomb]
tag @a remove attacker_temp

# --- 次のサイクルの準備 ---
scoreboard players remove @s ammo 1
scoreboard players set @s timer 5

# 終了判定
execute unless score @s ammo matches 1.. run kill @e[tag=adm_plane]
execute unless score @s ammo matches 1.. run kill @s