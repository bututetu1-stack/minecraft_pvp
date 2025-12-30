# CTチェック
execute if score @s cd_adm_artillery matches 1.. run return 0

# クールダウン設定 (400tick = 20秒)
scoreboard players set @s cd_adm_artillery 400
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1

# --- レイキャスト開始 ---
summon armor_stand ^ ^1.62 ^0.5 {Tags:["artillery_marker","new_marker"],Invisible:1b,NoGravity:1b}
scoreboard players operation @e[tag=new_marker,limit=1] player_id = @s player_id
data modify entity @e[tag=new_marker,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=new_marker] at @s run function my_pvp:roles/admiral/raycast_loop

# --- 結果判定 ---

# A. 失敗時 (射程外)
execute unless entity @e[tag=new_marker,tag=hit_block] run tellraw @s [{"text":"射程外です！地面や壁を狙ってください","color":"red"}]
execute unless entity @e[tag=new_marker,tag=hit_block] run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute unless entity @e[tag=new_marker,tag=hit_block] run scoreboard players set @s cd_adm_artillery 0
execute unless entity @e[tag=new_marker,tag=hit_block] run kill @e[tag=new_marker]

# B. 成功時 (hit_block あり) -> ガチャロジック実行

# 1. 乱数生成 (UUID方式: 0, 1, 2 の3通り)
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] store result score @s temp run data get entity @s UUID[0]
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] run scoreboard players set #CONST_3 temp 3
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] run scoreboard players operation @s temp %= #CONST_3 temp
# 負の数なら補正
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches ..-1 run scoreboard players add @s temp 3

# 2. 艦種決定 & 設定

# 【戦艦大和】 (temp=0) -> 10秒, 赤
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 0 run tag @s add type_yamato
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 0 run scoreboard players set @s temp 200
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 0 run data modify entity @s CustomName set value '{"text":"戦艦大和","color":"dark_red","bold":true}'

# 【戦艦金剛】 (temp=1) -> 3秒, 金
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 1 run tag @s add type_kongo
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 1 run scoreboard players set @s temp 60
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 1 run data modify entity @s CustomName set value '{"text":"戦艦金剛","color":"gold","bold":true}'

# 【戦艦長門】 (temp=2) -> 5秒, 紫
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 2 run tag @s add type_nagato
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 2 run scoreboard players set @s temp 100
execute if entity @e[tag=new_marker,tag=hit_block] as @e[tag=new_marker] if score @s temp matches 2 run data modify entity @s CustomName set value '{"text":"戦艦長門","color":"light_purple","bold":true}'


# --- 3. メッセージと演出 (艦種別) ---

# 共通演出 (音と光)
execute if entity @e[tag=new_marker,tag=hit_block] at @e[tag=new_marker] run playsound minecraft:entity.tnt.primed master @a[distance=..30] ~ ~ ~ 1 0.5
execute if entity @e[tag=new_marker,tag=hit_block] at @e[tag=new_marker] run particle minecraft:flash ~ ~ ~ 0 0 0 1 10

# === A. 戦艦大和 (type_yamato) ===
# 警告 (半径15m)
execute if entity @e[tag=new_marker,tag=hit_block,tag=type_yamato] at @e[tag=new_marker] run tellraw @a[distance=..15] [{"text":"[警告] ","color":"red","bold":true},{"text":"現在地に戦艦大和による砲撃支援が開始されます！退避してください！","color":"yellow","bold":false}]
# 提督へのセリフ
execute if entity @e[tag=new_marker,tag=hit_block,tag=type_yamato] as @e[tag=new_marker] run tellraw @p[tag=admiral] [{"text":"[大和] ","color":"dark_red","bold":true},{"text":"大和、砲雷撃戦、はじめます！","color":"white","bold":false}]

# === B. 戦艦金剛 (type_kongo) ===
# 警告 (半径8m)
execute if entity @e[tag=new_marker,tag=hit_block,tag=type_kongo] at @e[tag=new_marker] run tellraw @a[distance=..8] [{"text":"[警告] ","color":"red","bold":true},{"text":"現在地に戦艦金剛による砲撃支援が開始されます！退避してください！","color":"yellow","bold":false}]
# 提督へのセリフ
execute if entity @e[tag=new_marker,tag=hit_block,tag=type_kongo] as @e[tag=new_marker] run tellraw @p[tag=admiral] [{"text":"[金剛] ","color":"gold","bold":true},{"text":"撃ちます！　Fire～！","color":"white","bold":false}]

# === C. 戦艦長門 (type_nagato) ===
# 警告 (半径10m)
execute if entity @e[tag=new_marker,tag=hit_block,tag=type_nagato] at @e[tag=new_marker] run tellraw @a[distance=..10] [{"text":"[警告] ","color":"red","bold":true},{"text":"現在地に戦艦長門による砲撃支援が開始されます！退避してください！","color":"yellow","bold":false}]
# 提督へのセリフ
execute if entity @e[tag=new_marker,tag=hit_block,tag=type_nagato] as @e[tag=new_marker] run tellraw @p[tag=admiral] [{"text":"[長門] ","color":"light_purple","bold":true},{"text":"行くぞ、主砲一斉射！て――ッ！！","color":"white","bold":false}]

# タグ整理
tag @e[tag=new_marker] remove new_marker