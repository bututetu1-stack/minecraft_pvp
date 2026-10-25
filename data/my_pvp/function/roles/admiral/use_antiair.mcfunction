# 1. CTチェック
execute if score @s cd_adm_aa matches 1.. run return 0

# 2. 基本CT設定 (一律 20秒 = 400tick)
scoreboard players set @s cd_adm_aa 400

# 3. 防御マーカーの設置 (自分の位置)
summon area_effect_cloud ~ ~ ~ {Tags:["aa_center","new_aa"],Duration:200}

# ID継承 (自分が出した対空として識別する場合に使用)
scoreboard players operation #OWNER_ID temp = @s player_id
execute as @e[tag=new_aa] run scoreboard players operation @s player_id = #OWNER_ID temp

# --- 4. 艦種抽選 (ガチャ) ---
# 0: 秋月, 1: 摩耶, 2: Johnston
scoreboard players set #CONST_3 temp 3
execute as @e[tag=new_aa] store result score @s temp run data get entity @s UUID[0]
execute as @e[tag=new_aa] run scoreboard players operation @s temp %= #CONST_3 temp
execute as @e[tag=new_aa] if score @s temp matches ..-1 run scoreboard players add @s temp 3

# --- 5. パラメータ & セリフ設定 ---

# === A. 秋月 (temp=0) - 防御型 防空陣 ===
# 効果: 10秒 (200tick) - 飛び道具撃墜 + 自己耐性 + 空中の敵に slow_falling 剥がし & 軽ダメージ
execute as @e[tag=new_aa] if score @s temp matches 0 run tag @s add type_akizuki
execute as @e[tag=new_aa] if score @s temp matches 0 run scoreboard players set @s timer 200
execute as @e[tag=new_aa] if score @s temp matches 0 at @s run tellraw @p[tag=admiral,limit=1,distance=..5] [{"text":"[秋月] ","color":"green","bold":true},{"text":"この秋月が健在な限り、やらせはしません！","color":"white","bold":false}]
# 【更新】効果説明
execute as @e[tag=new_aa] if score @s temp matches 0 at @s run tellraw @p[tag=admiral,limit=1,distance=..5] [{"text":"[効果] ","color":"gray"},{"text":"防空陣: 飛び道具撃墜 + 空中の敵に弾幕 (10秒)","color":"green"}]
execute as @e[tag=new_aa] if score @s temp matches 0 at @s run playsound minecraft:entity.iron_golem.repair master @a ~ ~ ~ 1 1.5

# === B. 摩耶 (temp=1) - 攻撃型 高角砲 ===
# 効果: 5秒 (100tick) - 空中の敵に高威力ダメージ
execute as @e[tag=new_aa] if score @s temp matches 1 run tag @s add type_maya
# Duration更新
execute as @e[tag=new_aa] if score @s temp matches 1 run data merge entity @s {Duration:100}
execute as @e[tag=new_aa] if score @s temp matches 1 run scoreboard players set @s timer 100
execute as @e[tag=new_aa] if score @s temp matches 1 at @s run tellraw @p[tag=admiral,limit=1,distance=..5] [{"text":"[摩耶] ","color":"red","bold":true},{"text":"摩耶様の攻撃、喰らえ～っ！","color":"white","bold":false}]
# 【更新】効果説明
execute as @e[tag=new_aa] if score @s temp matches 1 at @s run tellraw @p[tag=admiral,limit=1,distance=..5] [{"text":"[効果] ","color":"gray"},{"text":"高角砲: 空中の敵に高威力ダメージ (5秒)","color":"red"}]
execute as @e[tag=new_aa] if score @s temp matches 1 at @s run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 0.8

# === C. Johnston (temp=2) - 撃墜型 急降下迎撃 ===
# 効果: 8秒 (160tick) - 自己機動強化 + 空中の敵を撃墜・弱体化 + 近接飛び道具撃墜
execute as @e[tag=new_aa] if score @s temp matches 2 run tag @s add type_johnston
execute as @e[tag=new_aa] if score @s temp matches 2 run scoreboard players set @s timer 160
execute as @e[tag=new_aa] if score @s temp matches 2 at @s run tellraw @p[tag=admiral,limit=1,distance=..5] [{"text":"[Johnston] ","color":"blue","bold":true},{"text":"突撃よ！　Open fire！","color":"white","bold":false}]
# 【更新】効果説明
execute as @e[tag=new_aa] if score @s temp matches 2 at @s run tellraw @p[tag=admiral,limit=1,distance=..5] [{"text":"[効果] ","color":"gray"},{"text":"急降下迎撃: 自己機動強化 + 空中の敵を撃墜・発光 (8秒)","color":"aqua"}]
execute as @e[tag=new_aa] if score @s temp matches 2 at @s run playsound minecraft:entity.firework_rocket.blast master @a ~ ~ ~ 1 1.2

# 後処理
tag @e[tag=new_aa] remove new_aa