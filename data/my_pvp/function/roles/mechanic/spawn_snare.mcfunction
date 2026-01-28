# スクラップを16消費
execute unless entity @s[tag=rush_mode] run scoreboard players remove @s scrap 16

# CT設定 (15s = 300ticks)
execute unless entity @s[tag=rush_mode] run scoreboard players set @s cd_snare 300
execute if entity @s[tag=rush_mode] run scoreboard players set @s cd_snare 0
execute if entity @s[tag=rush_mode] run item replace entity @s container.3 with minecraft:compass[custom_name='{"text":"重力スネア","italic":false,"color":"light_purple"}',lore=['{"text":"Cost: 16 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:4b}] 1




# 1. 中心点の召喚
summon marker ~ ~ ~ {Tags:["gadget","snare"]}

# 2. 稼働時間の設定 (100tick = 5秒)
execute as @e[tag=snare,limit=1,sort=nearest] run scoreboard players set @s gadget_life 100

# 3. 所有者IDのコピー
execute as @e[tag=snare,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 4. 設置音と演出
playsound minecraft:block.beacon.activate ambient @a ~ ~ ~ 2 0.5
particle minecraft:reverse_portal ~ ~0.5 ~ 0 0 0 0.5 50