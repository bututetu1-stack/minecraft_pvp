# 夜戦: 航空支援生成 (3種ガチャ Suisei/Reppu/Ryusei)
# 実行位置: ターゲットプレイヤー周辺

# ランダムオフセット
summon marker ~ ~ ~ {Tags:["pos_marker"]}
execute as @e[tag=pos_marker] run spreadplayers ~ ~ 0 15 false @s
execute at @e[tag=pos_marker] run summon marker ~ ~ ~ {Tags:["bomb_marker","night_bomb","adm_bomb","bomb_falling","new_night_bomb"]}
kill @e[tag=pos_marker]

# 設定
execute as @e[tag=new_night_bomb] run scoreboard players set @s temp 40
execute as @e[tag=new_night_bomb] run scoreboard players set @s player_id 0
# 最初は空中に配置
execute as @e[tag=new_night_bomb] at @s run tp @s ~ ~20 ~

# UUIDからランダムで 0/1/2 抽選 (3種)
execute as @e[tag=new_night_bomb,limit=1] store result score #BOMB_TYPE temp run data get entity @s UUID[0]
scoreboard players set #CONST_3 temp 3
scoreboard players operation #BOMB_TYPE temp %= #CONST_3 temp
execute if score #BOMB_TYPE temp matches ..-1 run scoreboard players add #BOMB_TYPE temp 3

# A. Suisei (0)
execute if score #BOMB_TYPE temp matches 0 as @e[tag=new_night_bomb] run tag @s add type_suisei
execute if score #BOMB_TYPE temp matches 0 as @e[tag=new_night_bomb] run data merge entity @s {CustomName:'{"text":"彗星一二型甲","color":"red","bold":true}'}

# B. Reppu (1)
execute if score #BOMB_TYPE temp matches 1 as @e[tag=new_night_bomb] run tag @s add type_reppu
execute if score #BOMB_TYPE temp matches 1 as @e[tag=new_night_bomb] run data merge entity @s {CustomName:'{"text":"烈風","color":"green","bold":true}'}

# C. Ryusei (2)
execute if score #BOMB_TYPE temp matches 2 as @e[tag=new_night_bomb] run tag @s add type_ryusei
execute if score #BOMB_TYPE temp matches 2 as @e[tag=new_night_bomb] run data merge entity @s {CustomName:'{"text":"流星","color":"blue","bold":true}'}

# 後始末
tag @e[tag=new_night_bomb] remove new_night_bomb

# 警告音
playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 1 0.5
