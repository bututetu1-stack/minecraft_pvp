# 石化光線レイキャスト
# 0.5mごとに前進して敵命中 / ブロック衝突 / 距離切れ判定
# 呼び出し前に #beam_dist temp = 24 (12m), #TEMP player_id = caster, #BEAM_HIT temp = 0 セット

# 1. ブロック衝突判定 (透明ブロック以外で停止)
execute unless block ~ ~ ~ #my_pvp:transparent run particle minecraft:block{block_state:{Name:"minecraft:stone"}} ~ ~ ~ 0.2 0.2 0.2 0.05 5 force
execute unless block ~ ~ ~ #my_pvp:transparent run return 0

# 2. 軌跡パーティクル (毎ステップ)
particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~ ~ 0.05 0.05 0.05 0 1 force
particle minecraft:dust{color:[0.55,0.4,0.7],scale:0.8} ~ ~ ~ 0.05 0.05 0.05 0 1 force

# 3. 敵命中判定 (半径1.5m以内、自分以外)
tag @a remove beam_hit
execute as @a[distance=..1.5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add beam_hit

# 命中時: ダメージ 6 + 鈍足IV 4秒 + glowing 4秒
execute as @a[tag=beam_hit] run damage @s 6 minecraft:magic by @p[tag=sculptor,distance=..30,limit=1]
execute as @a[tag=beam_hit] run effect give @s minecraft:slowness 4 3 true
execute as @a[tag=beam_hit] run effect give @s minecraft:glowing 4 0 true
# 命中エフェクト
execute if entity @a[tag=beam_hit] run scoreboard players set #BEAM_HIT temp 1
execute as @a[tag=beam_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute as @a[tag=beam_hit] at @s run particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
execute as @a[tag=beam_hit] at @s run particle minecraft:block{block_state:{Name:"minecraft:stone"}} ~ ~1 ~ 0.4 0.4 0.4 0.1 15 force

tag @a remove beam_hit
# 命中したら停止
execute if score #BEAM_HIT temp matches 1 run return 1

# 4. 再帰 (距離制限)
scoreboard players remove #beam_dist temp 1
execute if score #beam_dist temp matches 1.. positioned ^ ^ ^0.5 run function my_pvp:roles/sculptor/beam_raycast
