# 煙幕弾発動

# CTセット (22秒 = 440tick)
scoreboard players set @s cd_sharp_smoke 440

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 自分に invisibility
effect give @s minecraft:invisibility 4 0 true

# 半径4の敵に blindness
execute at @s as @a[gamemode=!spectator,distance=..4] unless score @s player_id = #TEMP player_id run effect give @s minecraft:blindness 3 0 true

# 演出
playsound minecraft:entity.firework_rocket.blast master @a ~ ~ ~ 1.2 0.6
playsound minecraft:block.fire.extinguish master @a ~ ~ ~ 1.5 0.7
particle minecraft:large_smoke ~ ~1 ~ 1.5 1 1.5 0.05 60 force
particle minecraft:cloud ~ ~1 ~ 1.5 1 1.5 0 40 force
particle minecraft:smoke ~ ~ ~ 2 0.5 2 0 80 force

tellraw @s [{"text":"[煙幕弾] ","color":"gray","bold":true},{"text":"煙に紛れて消える","color":"yellow"}]
