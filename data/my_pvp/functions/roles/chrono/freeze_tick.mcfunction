# 1. 自分のIDを一時変数に記録
scoreboard players operation #TEMP_ID temp = @s player_id

# 2. ターゲットマーキング (TPされる対象として自分をマーク)
tag @s add tp_target

# 3. アンカーの位置から、自分(@s)を引き寄せる
# (IDが一致するアンカーの場所で実行し、そこにターゲットをTPさせる)
execute as @e[type=marker,tag=freeze_anchor] if score @s player_id = #TEMP_ID temp at @s run tp @a[tag=tp_target,limit=1] ~ ~ ~

# 4. マーク解除
tag @s remove tp_target

# 5. 演出 (アクションバーとパーティクル)
title @s actionbar {"text":"|| 時間停止中 ||","color":"aqua"}
particle minecraft:snowflake ~ ~1 ~ 0.5 1 0.5 0.05 5 force