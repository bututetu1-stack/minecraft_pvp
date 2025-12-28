# 1. 演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 0.8
particle minecraft:explosion_emitter ~ ~ ~ 1 0 1 0 1
particle minecraft:dust 1.0 0.0 0.0 2.0 ~ ~0.2 ~ 2 0 2 1 50

# 2. ターゲット選定 (半径4マスの敵)
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove slam_target
execute as @a[distance=..4,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add slam_target

# 3. ダメージ付与 (8ダメージ)
execute as @a[tag=slam_target] run damage @s 8 minecraft:player_attack by @p[tag=berserker,limit=1,distance=..4]

# 4. キル判定 (ポイント加算)
execute as @a[tag=slam_target,tag=!dead_processing] store result score #TARGET_HP temp run data get entity @s Health 100
execute as @a[tag=slam_target,tag=!dead_processing] if score #TARGET_HP temp matches ..0 run scoreboard players add @s[tag=berserker] kills 1
execute as @a[tag=slam_target] if score #TARGET_HP temp matches ..0 run tag @s add dead_processing

# 5. 後始末
tag @a remove slam_target
tag @s remove ber_leaping
tag @s remove ber_slamming