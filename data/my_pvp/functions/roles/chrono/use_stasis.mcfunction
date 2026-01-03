# CTセット (30秒 = 600tick)
scoreboard players set @s cd_chrono_stasis 600

# 音と演出
playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 2 0.5
particle minecraft:reverse_portal ~ ~1 ~ 10 10 10 0.1 200 force
tellraw @a [{"text":"時よ、止まれ！ (Time Stop: 10s)","color":"yellow","bold":true}]

# 範囲内の対象を凍結 (半径20m以内)
tag @a[distance=..20,tag=!chrono] add is_frozen
execute as @e[distance=..20,type=!player] unless entity @s[tag=chrono] run tag @s add is_frozen

# 凍結時間をセット (10秒 = 200tick)
execute as @e[tag=is_frozen] run scoreboard players set @s freeze_timer 200