# 1. 自分のIDを一時変数に記録
scoreboard players operation #TEMP_ID temp = @s player_id

# 2. 自分のIDを持つアンカーを破壊
execute as @e[type=marker,tag=freeze_anchor] if score @s player_id = #TEMP_ID temp run kill @s

# 3. タグ消去
tag @s remove has_anchor