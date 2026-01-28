# Process Shield Drop
# @s = item entity

# 1. 所有者を特定
scoreboard players operation #TEMP player_id = @s player_id
tag @s add current_item

# 2. 所有者にアイテムを返す & スキル発動
execute as @a[tag=tank] if score @s player_id = #TEMP player_id run function my_pvp:roles/tank/shield_bash/return_and_start

# 3. アイテム消去
kill @s
