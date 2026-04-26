# 狙撃弾レイキャスト (0.5mごと)
# 呼び出し元で #snipe_dist temp = 60, #TEMP player_id, #SNIPE_HIT temp = 0 をセット

# 1. ブロック衝突判定
execute unless block ~ ~ ~ #my_pvp:transparent run particle minecraft:block{block_state:{Name:"minecraft:stone"}} ~ ~ ~ 0.2 0.2 0.2 0.05 5 force
execute unless block ~ ~ ~ #my_pvp:transparent run return 0

# 2. 軌跡パーティクル
particle minecraft:dust{color:[1.0,0.2,0.2],scale:0.5} ~ ~ ~ 0 0 0 0 1 force
particle minecraft:enchanted_hit ~ ~ ~ 0 0 0 0 1 force

# 3. 敵命中判定 (半径1.5m、自分以外)
tag @a remove snipe_hit
execute as @a[distance=..1.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add snipe_hit

# 命中時: ダメージ 8 + glowing
execute as @a[tag=snipe_hit] run damage @s 8 minecraft:magic by @p[tag=sharpshooter,distance=..40,limit=1]
execute as @a[tag=snipe_hit] run effect give @s minecraft:glowing 5 0 true
execute if entity @a[tag=snipe_hit] run scoreboard players set #SNIPE_HIT temp 1
execute as @a[tag=snipe_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute as @a[tag=snipe_hit] at @s run particle minecraft:dust{color:[1.0,0.0,0.0],scale:1.5} ~ ~1 ~ 0.5 0.5 0.5 0 25 force

tag @a remove snipe_hit
# 命中で停止 (貫通させたい場合は return しない)
execute if score #SNIPE_HIT temp matches 1 run return 1

# 4. 再帰
scoreboard players remove #snipe_dist temp 1
execute if score #snipe_dist temp matches 1.. positioned ^ ^ ^0.5 run function my_pvp:roles/sharpshooter/snipe_raycast
