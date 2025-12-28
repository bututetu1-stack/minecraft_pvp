# スクラップを8消費 (9 -> 8)
scoreboard players remove @s scrap 8

# 1. 中心点の召喚
summon marker ~ ~ ~ {Tags:["gadget","snare"]}

# 2. 稼働時間の設定 (100tick = 5秒)
execute as @e[tag=snare,limit=1,sort=nearest] run scoreboard players set @s gadget_life 100

# 3. 所有者IDのコピー
execute as @e[tag=snare,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 4. 設置音と演出
playsound minecraft:block.beacon.activate ambient @a ~ ~ ~ 2 0.5
particle minecraft:reverse_portal ~ ~0.5 ~ 0 0 0 0.5 50