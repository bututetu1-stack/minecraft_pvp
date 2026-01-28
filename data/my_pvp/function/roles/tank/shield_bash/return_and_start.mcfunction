# Return Shield & Try Start
# @s = player

# 1. アイテム返却
execute unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_shield:1b}}}]}] run give @s minecraft:paper[minecraft:custom_model_data=1,minecraft:custom_data={tank_shield:1b},minecraft:custom_name='{"text":"シールドバッシュ","color":"blue","bold":true}',minecraft:lore=['{"text":"[Q]キーでドロップして突進 (2s)","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={}] 1

# 2. スキル試行
function my_pvp:roles/tank/shield_bash/start
