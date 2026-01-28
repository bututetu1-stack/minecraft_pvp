# Cleanup
scoreboard players set @s shield_dash_timer 0
tag @s add end_processing
scoreboard players operation #TEMP player_id = @s player_id

# マーカー消去
execute as @e[tag=bash_guide] if score @s player_id = #TEMP player_id run kill @s

tag @s remove end_processing
tag @s remove current_dasher

# Reset Knockback
attribute @s minecraft:generic.attack_knockback base set 0.0

# Clear Hit Tags
tag @a remove bashed_temp
