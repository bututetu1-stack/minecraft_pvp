# 1. UI表示 (アクションバー)
title @s actionbar [{"text":"Sculpture: ","color":"blue"},{"score":{"name":"@s","objective":"cd_sculptor_create"},"color":"white"},{"text":" | Beam: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_sculptor_beam"},"color":"white"}]

# 2. クールダウン消化
execute as @s[scores={cd_sculptor_create=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_sculptor_create=1..}] cd_sculptor_create 1

# 3. 石化光線 CT終了時のアイテム自動返却 (バーサーカーパターン)
execute as @s[scores={cd_sculptor_beam=1}] run item replace entity @s container.1 with minecraft:amethyst_shard[minecraft:custom_data={sculptor_beam:1b},minecraft:custom_name='{"text":"石化光線","color":"blue","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 石化光線発射","color":"yellow"}','{"text":"視線方向12m先まで貫通、命中で6ダメ + 鈍足IV","color":"gray"}','{"text":"CT: 10s","color":"aqua"}']] 1
execute as @s[scores={cd_sculptor_beam=1}] run playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 1 1.5
scoreboard players remove @s[scores={cd_sculptor_beam=1..}] cd_sculptor_beam 1

# 4. 役職固有 上昇スキル: 石柱噴出
execute if score @s cd_sculptor_pillar matches 1.. run scoreboard players remove @s cd_sculptor_pillar 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/sculptor/use_pillar
