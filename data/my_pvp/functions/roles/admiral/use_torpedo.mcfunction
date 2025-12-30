# CTチェック (200 ticks = 10秒)
execute if score @s cd_adm_torpedo matches 1.. run return 0

# 発動
scoreboard players set @s cd_adm_torpedo 200
playsound minecraft:item.trident.riptide_1 master @a ~ ~ ~ 1 0.5
tellraw @s {"text":"⚡ 魚雷発射！","color":"aqua"}

# 3発召喚 (一時タグ new_torp を付与)
summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp"],Invisible:1b,Marker:1b,NoGravity:1b}
summon armor_stand ^1 ^1 ^1 {Tags:["adm_torpedo","new_torp"],Invisible:1b,Marker:1b,NoGravity:1b}
summon armor_stand ^-1 ^1 ^1 {Tags:["adm_torpedo","new_torp"],Invisible:1b,Marker:1b,NoGravity:1b}

# --- 初期設定 ---
# 1. 向きをプレイヤーに合わせる
execute as @e[tag=new_torp] run data modify entity @s Rotation set from entity @p Rotation

# 2. 【追加】 誰が撃ったか(ID)を魚雷に刻む
scoreboard players operation @e[tag=new_torp] player_id = @s player_id

# タグ削除
tag @e[tag=new_torp] remove new_torp