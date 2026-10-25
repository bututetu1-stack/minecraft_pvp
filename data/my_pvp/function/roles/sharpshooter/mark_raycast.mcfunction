# マーキング弾レイキャスト (0.5mごと、距離25m)
# 呼び出し元で #mark_dist temp = 50, #TEMP player_id, #MARK_HIT temp = 0

# 1. ブロック衝突判定
execute unless block ~ ~ ~ #my_pvp:transparent run particle minecraft:dust{color:[1.0,1.0,0.3],scale:0.8} ~ ~ ~ 0.2 0.2 0.2 0.05 5 force
execute unless block ~ ~ ~ #my_pvp:transparent run return 0

# 2. 軌跡パーティクル (黄色)
particle minecraft:dust{color:[1.0,1.0,0.3],scale:0.5} ~ ~ ~ 0 0 0 0 1 force
particle minecraft:end_rod ~ ~ ~ 0 0 0 0 1 force

# 3. 敵命中判定 (半径1.3m、自分以外)
tag @a remove mark_hit
execute as @a[distance=..1.3,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add mark_hit

# 命中時: ダメージ 3 + glowing 5秒 + slowness II 5秒
execute as @a[tag=mark_hit] run damage @s 3 minecraft:magic by @p[tag=sharpshooter,distance=..40,limit=1]
execute as @a[tag=mark_hit] run effect give @s minecraft:glowing 5 0 true
execute as @a[tag=mark_hit] run effect give @s minecraft:slowness 5 1 true
execute if entity @a[tag=mark_hit] run scoreboard players set #MARK_HIT temp 1
execute as @a[tag=mark_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute as @a[tag=mark_hit] at @s run particle minecraft:dust{color:[1.0,0.9,0.0],scale:1.3} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
execute as @a[tag=mark_hit] at @s run particle minecraft:end_rod ~ ~1 ~ 0.3 0.3 0.3 0.05 10 force
execute if entity @a[tag=mark_hit] run playsound minecraft:block.amethyst_block.chime master @p[tag=sharpshooter,limit=1] ~ ~ ~ 1.2 1.5

tag @a remove mark_hit
# 命中で停止
execute if score #MARK_HIT temp matches 1 run return 1

# 4. 再帰
scoreboard players remove #mark_dist temp 1
execute if score #mark_dist temp matches 1.. positioned ^ ^ ^0.5 run function my_pvp:roles/sharpshooter/mark_raycast
