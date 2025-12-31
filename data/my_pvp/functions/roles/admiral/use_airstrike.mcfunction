# CTチェック
execute if score @s cd_adm_air matches 1.. run return 0

# --- 変更点: CTを 800 -> 600 (30秒) に短縮 ---
scoreboard players set @s cd_adm_air 600

tellraw @a [{"text":"味方航空支援艦隊が到着しました！","color":"red"}]

# --- マーカー設置 ---
summon armor_stand ^ ^1.62 ^0.5 {Tags:["temp_air_marker"],Invisible:1b,NoGravity:1b,Marker:1b}
data modify entity @e[tag=temp_air_marker,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=temp_air_marker] at @s run function my_pvp:roles/admiral/raycast_loop
# 生存時間を延長 (600tick)
execute at @e[tag=temp_air_marker] run summon area_effect_cloud ~ ~ ~ {Tags:["airstrike_center"],Duration:600}

# IDをコピー (キルログ用)
scoreboard players operation @e[tag=airstrike_center,sort=nearest,limit=1] player_id = @s player_id
# ランダムな向きから開始
execute store result entity @e[tag=airstrike_center,sort=nearest,limit=1] Rotation[0] float 1 run time query gametime

kill @e[tag=temp_air_marker]

# --- 艦種決定 (ガチャ) ---
# 1. 乱数生成 (3通り 0,1,2)
execute as @e[tag=airstrike_center,sort=nearest,limit=1] store result score @s temp run data get entity @s UUID[0]
execute as @e[tag=airstrike_center,sort=nearest,limit=1] run scoreboard players set #CONST_3 temp 3
execute as @e[tag=airstrike_center,sort=nearest,limit=1] run scoreboard players operation @s temp %= #CONST_3 temp
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches ..-1 run scoreboard players add @s temp 3


# 2. パラメータ設定

# === A. 正規空母 加賀 (temp=0) ===
# 青, 弾数20, 起動遅い(100), 半径30
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run tag @s add type_kaga
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run scoreboard players set @s ammo 20
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run scoreboard players set @s timer 100
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run tellraw @p[tag=admiral] [{"text":"[加賀] ","color":"blue","bold":true},{"text":"鎧袖一触よ。心配いらないわ。","color":"white","bold":false}]

# === B. 正規空母 瑞鶴 (temp=1) ===
# 緑, 弾数15, 通常(60), 半径25
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run tag @s add type_zuikaku
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run scoreboard players set @s ammo 15
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run scoreboard players set @s timer 60
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run tellraw @p[tag=admiral] [{"text":"[瑞鶴] ","color":"green","bold":true},{"text":"アウトレンジで…決めたいわね！","color":"white","bold":false}]

# === C. 軽空母 瑞鳳 (temp=2) ===
# 赤, 弾数10, 速攻(30), 半径20
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run tag @s add type_zuiho
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run scoreboard players set @s ammo 10
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run scoreboard players set @s timer 30
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run tellraw @p[tag=admiral] [{"text":"[瑞鳳] ","color":"red","bold":true},{"text":"はい、瑞鳳もご一緒します。勿論！","color":"white","bold":false}]


# --- ファントム召喚 ---
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~ ~15 ~10 {Tags:["adm_plane","plane_1"],NoAI:1b,Size:5,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~10 ~18 ~-5 {Tags:["adm_plane","plane_2"],NoAI:1b,Size:3,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~-10 ~18 ~-5 {Tags:["adm_plane","plane_3"],NoAI:1b,Size:3,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 5 0.5