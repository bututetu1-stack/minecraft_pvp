# 魔導弾レイキャスト (0.5mごとに前進)
# 呼び出し元で #shot_dist temp = 40 (20m), #TEMP player_id = caster, #SHOT_HIT temp = 0 をセット

# 1. ブロック衝突判定
execute unless block ~ ~ ~ #my_pvp:transparent run particle minecraft:dust{color:[0.5,0.7,1.0],scale:0.8} ~ ~ ~ 0.2 0.2 0.2 0.05 5 force
execute unless block ~ ~ ~ #my_pvp:transparent run return 0

# 2. 軌跡パーティクル (青魔導の弾道)
particle minecraft:dust{color:[0.4,0.7,1.0],scale:0.5} ~ ~ ~ 0 0 0 0 1 force
particle minecraft:enchant ~ ~ ~ 0 0 0 0.1 1 force

# 3. 敵命中判定 (半径1.2m、自分以外)
tag @a remove shot_hit
execute as @a[distance=..1.2,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add shot_hit

# 命中時: ダメージ 4
execute as @a[tag=shot_hit] run damage @s 4 minecraft:magic by @p[tag=sharpshooter,distance=..30,limit=1]
execute if entity @a[tag=shot_hit] run scoreboard players set #SHOT_HIT temp 1
execute as @a[tag=shot_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute as @a[tag=shot_hit] at @s run particle minecraft:dust{color:[0.5,0.7,1.0],scale:1.0} ~ ~1 ~ 0.4 0.4 0.4 0 15 force
execute if entity @a[tag=shot_hit] run playsound minecraft:entity.arrow.hit_player master @p[tag=sharpshooter,limit=1] ~ ~ ~ 1 1.5

tag @a remove shot_hit
# 命中で停止
execute if score #SHOT_HIT temp matches 1 run return 1

# 4. 再帰
scoreboard players remove #shot_dist temp 1
execute if score #shot_dist temp matches 1.. positioned ^ ^ ^0.5 run function my_pvp:roles/sharpshooter/auto_fire_raycast
