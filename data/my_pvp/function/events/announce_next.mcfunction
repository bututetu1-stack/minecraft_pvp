# 次のイベントを抽選して告知 (10秒前)

# ランダム値を生成 (1-7)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #EVENT_RNG temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
scoreboard players set #CONST_8 temp 8
scoreboard players operation #EVENT_RNG temp %= #CONST_8 temp
scoreboard players add #EVENT_RNG temp 1
kill @e[tag=random_seed]

# 次のイベントタイプを一時保存
scoreboard players operation #NEXT_EVENT_TYPE temp = #EVENT_RNG temp

# 告知
title @a title {"text":"Next Event...","color":"gray"}
execute if score #NEXT_EVENT_TYPE temp matches 1 run title @a subtitle {"text":"濃霧 (Fog) - 10s","color":"gray"}
execute if score #NEXT_EVENT_TYPE temp matches 2 run title @a subtitle {"text":"低重力 (Low Gravity) - 10s","color":"aqua"}
execute if score #NEXT_EVENT_TYPE temp matches 3 run title @a subtitle {"text":"賞金首 (Bounty) - 10s","color":"red"}
execute if score #NEXT_EVENT_TYPE temp matches 4 run title @a subtitle {"text":"サドンデス (Sudden Death) - 10s","color":"dark_red"}
execute if score #NEXT_EVENT_TYPE temp matches 5 run title @a subtitle {"text":"ラッシュモード (Rush) - 10s","color":"gold"}
execute if score #NEXT_EVENT_TYPE temp matches 6 run title @a subtitle {"text":"夜戦 (Night Battle) - 10s","color":"dark_purple"}
execute if score #NEXT_EVENT_TYPE temp matches 7 run title @a subtitle {"text":"ルーレット (Roulette) - 10s","color":"green"}
execute if score #NEXT_EVENT_TYPE temp matches 8 run title @a subtitle {"text":"インフレーション (Inflation) - 10s","color":"gold"}

playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 0.5
