# CTチェック
execute if score @s cd_adm_air matches 1.. run return 0
scoreboard players set @s cd_adm_air 800
tellraw @a [{"text":"味方航空支援艦隊が到着しました！","color":"red"}]

# --- マーカー設置 ---
summon armor_stand ^ ^1.62 ^0.5 {Tags:["temp_air_marker"],Invisible:1b,NoGravity:1b,Marker:1b}
data modify entity @e[tag=temp_air_marker,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=temp_air_marker] at @s run function my_pvp:roles/admiral/raycast_loop
execute at @e[tag=temp_air_marker] run summon area_effect_cloud ~ ~ ~ {Tags:["airstrike_center"],Duration:400}

# IDをコピー (キルログ用)
scoreboard players operation @e[tag=airstrike_center,sort=nearest,limit=1] player_id = @s player_id
# 【追加】ランダムな向きから開始する (gametimeをYawに代入)
execute store result entity @e[tag=airstrike_center,sort=nearest,limit=1] Rotation[0] float 1 run time query gametime

kill @e[tag=temp_air_marker]

# --- 初期設定 ---
scoreboard players set @e[tag=airstrike_center,sort=nearest,limit=1] timer 60
scoreboard players set @e[tag=airstrike_center,sort=nearest,limit=1] ammo 10

# --- ファントム召喚 (旋回用にタグ分け) ---
# 親機 (plane_1): 前方
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~ ~15 ~10 {Tags:["adm_plane","plane_1"],NoAI:1b,Size:5,Invulnerable:1b}
# 僚機 (plane_2): 左後方
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~10 ~18 ~-5 {Tags:["adm_plane","plane_2"],NoAI:1b,Size:3,Invulnerable:1b}
# 僚機 (plane_3): 右後方
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~-10 ~18 ~-5 {Tags:["adm_plane","plane_3"],NoAI:1b,Size:3,Invulnerable:1b}

# 登場音
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 5 0.5