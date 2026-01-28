# CTチェック
execute if score @s cd_adm_air matches 1.. run return 0

# --- 変更点: CTを 600 (30秒) に短縮 (維持) ---
scoreboard players set @s cd_adm_air 600

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
execute as @e[tag=airstrike_center,sort=nearest,limit=1] store result score @s temp run data get entity @s UUID[0]
execute as @e[tag=airstrike_center,sort=nearest,limit=1] run scoreboard players set #CONST_3 temp 3
execute as @e[tag=airstrike_center,sort=nearest,limit=1] run scoreboard players operation @s temp %= #CONST_3 temp
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches ..-1 run scoreboard players add @s temp 3


# 2. パラメータ設定

# === A. 正規空母 加賀 (temp=0) ===
# 青, 弾数40 (倍増), 起動遅い(100), 半径30
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run tag @s add type_kaga
# 【変更】弾数を 20 -> 40 に変更
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run scoreboard players set @s ammo 40
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run scoreboard players set @s timer 100
# 範囲警告
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 at @s run tellraw @a[distance=..30] [{"text":"[警告] ","color":"red","bold":true},{"text":"加賀による航空支援が行われます！頭上に注意されたし！","color":"yellow","bold":false}]
# 提督セリフ
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 0 run tellraw @p[tag=admiral] [{"text":"[加賀] ","color":"blue","bold":true},{"text":"鎧袖一触よ。心配いらないわ。","color":"white","bold":false}]

# === B. 正規空母 瑞鶴 (temp=1) ===
# 緑, 弾数30 (倍増), 通常(60), 半径25
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run tag @s add type_zuikaku
# 【変更】弾数を 15 -> 30 に変更
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run scoreboard players set @s ammo 30
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run scoreboard players set @s timer 60
# 範囲警告
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 at @s run tellraw @a[distance=..25] [{"text":"[警告] ","color":"red","bold":true},{"text":"瑞鶴による航空支援が行われます！頭上に注意されたし！","color":"yellow","bold":false}]
# 提督セリフ
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 1 run tellraw @p[tag=admiral] [{"text":"[瑞鶴] ","color":"green","bold":true},{"text":"アウトレンジで…決めたいわね！","color":"white","bold":false}]

# === C. 軽空母 瑞鳳 (temp=2) ===
# 赤, 弾数20 (倍増), 速攻(30), 半径20
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run tag @s add type_zuiho
# 【変更】弾数を 10 -> 20 に変更
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run scoreboard players set @s ammo 20
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run scoreboard players set @s timer 30
# 範囲警告
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 at @s run tellraw @a[distance=..20] [{"text":"[警告] ","color":"red","bold":true},{"text":"瑞鳳による航空支援が行われます！頭上に注意されたし！","color":"yellow","bold":false}]
# 提督セリフ
execute as @e[tag=airstrike_center,sort=nearest,limit=1] if score @s temp matches 2 run tellraw @p[tag=admiral] [{"text":"[瑞鳳] ","color":"red","bold":true},{"text":"はい、瑞鳳もご一緒します。勿論！","color":"white","bold":false}]


# --- ファントム召喚 ---
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~ ~15 ~10 {Tags:["adm_plane","plane_1","new_plane"],NoAI:1b,Size:5,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~10 ~18 ~-5 {Tags:["adm_plane","plane_2","new_plane"],NoAI:1b,Size:3,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~-10 ~18 ~-5 {Tags:["adm_plane","plane_3","new_plane"],NoAI:1b,Size:3,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 5 0.5

# ID共有 (センターからコピー)
scoreboard players operation #OWNER_ID temp = @e[tag=airstrike_center,limit=1,sort=nearest] player_id
execute as @e[tag=new_plane] run scoreboard players operation @s player_id = #OWNER_ID temp
tag @e[tag=new_plane] remove new_plane