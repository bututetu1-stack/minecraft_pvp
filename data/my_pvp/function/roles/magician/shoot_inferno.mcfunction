# 業火爆裂 投射体スポーン (@s = magician, at @s)

# 1. armor_stand を視線+1.3 にスポーン
execute as @s at @s run summon armor_stand ^ ^1.62 ^1.3 {Tags:["mag_inferno","gadget"],NoGravity:1b,Marker:1b,Invisible:1b,Invulnerable:1b}
execute as @s at @s run data modify entity @e[type=armor_stand,tag=mag_inferno,limit=1,sort=nearest] Rotation set from entity @s Rotation

# 2. 所有者IDを記録 + 寿命カウンター初期化
execute as @s at @s run scoreboard players operation @e[type=armor_stand,tag=mag_inferno,limit=1,sort=nearest] player_id = @s player_id
execute as @s at @s run scoreboard players set @e[type=armor_stand,tag=mag_inferno,limit=1,sort=nearest] gadget_life 0

# 3. 発射演出
execute as @s at @s run playsound minecraft:entity.blaze.shoot master @a ~ ~ ~ 1.2 0.7
execute as @s at @s run playsound minecraft:item.firecharge.use master @a[distance=..30] ~ ~ ~ 1 1.0
execute as @s at @s run particle minecraft:flame ^ ^1.5 ^1 0.3 0.3 0.3 0.1 15
execute as @s at @s run particle minecraft:dust{color:[1.0,0.3,0.0],scale:1.5} ^ ^1.5 ^1 0.3 0.3 0.3 0 10
execute as @s at @s run particle minecraft:lava ^ ^1.5 ^1 0.2 0.2 0.2 0 3

tellraw @s [{"text":"[Inferno] ","color":"red","bold":true},{"text":"業火を放った！","color":"yellow"}]
