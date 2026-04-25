# 次のイベントを抽選して告知 (10秒前)
# 【修正】 1試合内で同じイベントが起きないように使用済みフラグでフィルタ

# リトライカウンタ初期化 (無限ループ防止)
scoreboard players set #ROLL_RETRY temp 0

# 抽選ループ呼び出し
function my_pvp:events/roll_next_event

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
