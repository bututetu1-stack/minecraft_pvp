# 1. UI表示 (アクションバー)
title @s actionbar [{"text":"Sculpture: ","color":"blue"},{"score":{"name":"@s","objective":"cd_sculptor_create"},"color":"white"}]

# 2. クールダウン消化
execute as @s[scores={cd_sculptor_create=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_sculptor_create=1..}] cd_sculptor_create 1

# 3. 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump
