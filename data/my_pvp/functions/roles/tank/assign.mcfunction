# 1. タグ付け
tag @s add tank
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『タンク』","color":"dark_green","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス強化 (体力40, KB耐性100%)
attribute @s minecraft:generic.max_health base set 40
attribute @s minecraft:generic.knockback_resistance base set 1.0

# 4. 回復 (最大値が増えたので全快させる)
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true

# 5. 音
playsound minecraft:entity.iron_golem.repair master @s ~ ~ ~ 1 1