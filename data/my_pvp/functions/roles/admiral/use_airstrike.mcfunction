# (前半のCTチェックなどはそのまま)
execute if score @s cd_adm_air matches 1.. run return 0
scoreboard players set @s cd_adm_air 800
tellraw @a [{"text":"味方航空支援艦隊が到着しました！","color":"red"}]

# --- マーカー設置 (レイキャスト版を推奨) ---
# 前回の修正でレイキャスト版にしている場合はそのままでOKですが、
# 重要なのは「player_idのコピー」です。

# (以下は前回のレイキャスト版を前提とした記述ですが、どの方式でもIDコピーを追加してください)
summon armor_stand ^ ^1.62 ^0.5 {Tags:["temp_air_marker"],Invisible:1b,NoGravity:1b,Marker:1b}
data modify entity @e[tag=temp_air_marker,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=temp_air_marker] at @s run function my_pvp:roles/admiral/raycast_loop
execute at @e[tag=temp_air_marker] run summon area_effect_cloud ~ ~ ~ {Tags:["airstrike_center"],Duration:400}

# 【重要追加】ここで生成した airstrike_center にIDをコピーする
scoreboard players operation @e[tag=airstrike_center,sort=nearest,limit=1] player_id = @s player_id

kill @e[tag=temp_air_marker]

# --- 初期設定 ---
# (以降はそのまま)
scoreboard players set @e[tag=airstrike_center,sort=nearest,limit=1] timer 60
scoreboard players set @e[tag=airstrike_center,sort=nearest,limit=1] ammo 10

# 演出
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~ ~15 ~5 {Tags:["adm_plane"],NoAI:1b,Size:3,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~5 ~17 ~5 {Tags:["adm_plane"],NoAI:1b,Size:2,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run summon phantom ~-5 ~17 ~5 {Tags:["adm_plane"],NoAI:1b,Size:2,Invulnerable:1b}
execute at @e[tag=airstrike_center,sort=nearest,limit=1] run playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 5 0.5