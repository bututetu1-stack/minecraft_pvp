# CTセット (20秒 = 400tick)
scoreboard players set @s cd_chrono_clockup 400

# 音と演出
playsound minecraft:block.bell.use master @a ~ ~ ~ 2 2
playsound minecraft:entity.phantom.flap master @a ~ ~ ~ 1 2
particle minecraft:electric_spark ~ ~1 ~ 0.5 0.5 0.5 0.1 30 force

# バフ付与 (10秒間)
effect give @s minecraft:speed 10 3 true
effect give @s minecraft:haste 10 2 true

# メッセージ
tellraw @s [{"text":">> Clock Up! (10s)","color":"red","bold":true}]