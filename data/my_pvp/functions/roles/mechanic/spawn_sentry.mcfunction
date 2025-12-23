# コスト支払い
scoreboard players remove @s scrap 5

# 防具立てを召喚 (Health:10で破壊可能)
summon armor_stand ~ ~ ~ {Tags:["gadget","sentry"],Health:10f,ShowArms:1b,Small:1b,CustomName:'{"text":"Micro Sentry","color":"gold"}'}

# 【最重要】設置した本人のIDをガジェットにコピー
execute as @e[tag=gadget,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

playsound minecraft:block.anvil.use ambient @a ~ ~ ~