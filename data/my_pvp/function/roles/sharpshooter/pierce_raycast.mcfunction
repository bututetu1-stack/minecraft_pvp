# 強撃弾レイキャスト (0.5mごと、距離35m, damage 14, 防御無視)
# 呼び出し元で #pierce_dist temp = 70, #TEMP player_id, #PIERCE_HIT temp = 0

# 1. ブロック衝突判定
execute unless block ~ ~ ~ #my_pvp:transparent run particle minecraft:block{block_state:{Name:"minecraft:stone"}} ~ ~ ~ 0.2 0.2 0.2 0.05 5 force
execute unless block ~ ~ ~ #my_pvp:transparent run return 0

# 2. 軌跡パーティクル (赤い太線)
particle minecraft:dust{color:[1.0,0.2,0.2],scale:0.7} ~ ~ ~ 0 0 0 0 1 force
particle minecraft:enchanted_hit ~ ~ ~ 0 0 0 0 1 force

# 3. 敵命中判定 (半径1.5m、自分以外)
tag @a remove pierce_hit
execute as @a[distance=..1.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add pierce_hit

# 命中時: ダメージ 14 (magic タイプ = 防御無視)
execute as @a[tag=pierce_hit] run damage @s 14 minecraft:magic by @p[tag=sharpshooter,distance=..50,limit=1]
execute if entity @a[tag=pierce_hit] run scoreboard players set #PIERCE_HIT temp 1
execute as @a[tag=pierce_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute as @a[tag=pierce_hit] at @s run particle minecraft:dust{color:[1.0,0.0,0.0],scale:1.8} ~ ~1 ~ 0.6 0.6 0.6 0 35 force
execute as @a[tag=pierce_hit] at @s run particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1 force
execute if entity @a[tag=pierce_hit] run playsound minecraft:item.trident.hit_ground master @p[tag=sharpshooter,limit=1] ~ ~ ~ 1.5 0.7

tag @a remove pierce_hit
# 命中で停止
execute if score #PIERCE_HIT temp matches 1 run return 1

# 4. 再帰
scoreboard players remove #pierce_dist temp 1
execute if score #pierce_dist temp matches 1.. positioned ^ ^ ^0.5 run function my_pvp:roles/sharpshooter/pierce_raycast
