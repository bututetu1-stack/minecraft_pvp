# CTセット (20秒 = 400tick)
scoreboard players set @s cd_chrono_reverse 400

# 5秒前のマーカーを探す
tag @s add reverse_user
execute at @s as @e[tag=chrono_5s,distance=..60,limit=1,sort=nearest] run tag @s add my_past_point

# マーカーが見つからない場合
execute unless entity @e[tag=my_past_point] run tellraw @s {"text":"Error: 戻れる過去がありません","color":"red"}
execute unless entity @e[tag=my_past_point] run tag @s remove reverse_user
execute unless entity @e[tag=my_past_point] run return 0

# --- 移動処理 ---
execute as @e[tag=my_past_point] run tp @a[tag=reverse_user] @s
kill @e[tag=my_past_point]

# --- 回復 & 演出 ---
effect give @s minecraft:instant_health 1 1 true
playsound minecraft:item.chorus_fruit.teleport master @a ~ ~ ~ 1 0.5
particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.5 0.5 0.1 50 force
tellraw @s [{"text":"<< Time Reverse (5s)","color":"aqua","bold":true}]

# タグ掃除
tag @s remove reverse_user