# マーカーの更新 (トコロテン方式: 5秒分)

# 1. 5秒前(一番古い)を消す
execute at @s run kill @e[tag=chrono_5s,distance=..0.1,limit=1]

# 2. 4秒前 -> 5秒前
execute at @s run tag @e[tag=chrono_4s,distance=..2] add chrono_5s
execute at @s run tag @e[tag=chrono_5s] remove chrono_4s

# 3. 3秒前 -> 4秒前
execute at @s run tag @e[tag=chrono_3s,distance=..2] add chrono_4s
execute at @s run tag @e[tag=chrono_4s] remove chrono_3s

# 4. 2秒前 -> 3秒前
execute at @s run tag @e[tag=chrono_2s,distance=..2] add chrono_3s
execute at @s run tag @e[tag=chrono_3s] remove chrono_2s

# 5. 1秒前 -> 2秒前
execute at @s run tag @e[tag=chrono_1s,distance=..2] add chrono_2s
execute at @s run tag @e[tag=chrono_2s] remove chrono_1s

# 6. 現在地に「1秒前マーカー」を設置
summon area_effect_cloud ~ ~ ~ {Tags:["chrono_marker","chrono_1s"],Duration:120}