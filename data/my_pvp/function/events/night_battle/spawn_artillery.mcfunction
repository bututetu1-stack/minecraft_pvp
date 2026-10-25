# 夜戦: 砲撃生成 (3種ガチャ Yamato/Kongo/Nagato)
# 実行位置: ターゲットプレイヤー周辺

# オフセット適用してマーカー設置 (この時点では type_* 未付与)
execute positioned ~ ~ ~ run summon marker ~ ~ ~ {Tags:["pos_marker"]}
execute as @e[tag=pos_marker] run spreadplayers ~ ~ 0 10 false @s
execute at @e[tag=pos_marker] run summon marker ~ ~ ~ {Tags:["artillery_marker","night_artillery","new_night_art"]}
kill @e[tag=pos_marker]

# マーカー基本設定
execute as @e[tag=new_night_art] run scoreboard players set @s temp 60
execute as @e[tag=new_night_art] run scoreboard players set @s player_id 0

# UUIDからランダムで 0/1/2 抽選 (3種)
execute as @e[tag=new_night_art,limit=1] store result score #ART_TYPE temp run data get entity @s UUID[0]
scoreboard players set #CONST_3 temp 3
scoreboard players operation #ART_TYPE temp %= #CONST_3 temp
execute if score #ART_TYPE temp matches ..-1 run scoreboard players add #ART_TYPE temp 3

# A. Yamato (0)
execute if score #ART_TYPE temp matches 0 as @e[tag=new_night_art] run tag @s add type_yamato
# B. Kongo (1)
execute if score #ART_TYPE temp matches 1 as @e[tag=new_night_art] run tag @s add type_kongo
# C. Nagato (2)
execute if score #ART_TYPE temp matches 2 as @e[tag=new_night_art] run tag @s add type_nagato

# 後始末
tag @e[tag=new_night_art] remove new_night_art

# 警告音
playsound minecraft:entity.lightning_bolt.impact master @a ~ ~ ~ 1 0.5
