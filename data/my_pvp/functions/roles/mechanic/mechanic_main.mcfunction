# 1. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 2. スクラップ配布 (5秒ごとに1増加)
scoreboard players operation @s temp = #GLOBAL match_timer
scoreboard players operation @s temp %= #100 temp
execute if score @s temp matches 0 if score #GLOBAL match_timer matches 1.. run scoreboard players add @s scrap 1

# スクラップ上限(100)
execute if score @s scrap matches 101.. run scoreboard players set @s scrap 100

# 3. クールダウン消化
scoreboard players remove @s[scores={cd_turret=1..}] cd_turret 1
scoreboard players remove @s[scores={cd_mine=1..}] cd_mine 1
scoreboard players remove @s[scores={cd_launcher=1..}] cd_launcher 1
scoreboard players remove @s[scores={cd_snare=1..}] cd_snare 1

# 4. レンチ操作検知 (Interactionエンティティ)
# 右クリック(interaction)検知
execute as @e[tag=gadget_hitbox,distance=..4] if data entity @s interaction run function my_pvp:roles/mechanic/wrench_click
# 左クリック(attack)検知
execute as @e[tag=sentry_hitbox,distance=..4] if data entity @s attack run function my_pvp:roles/mechanic/sentry_damage