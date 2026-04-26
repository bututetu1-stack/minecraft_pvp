# 狼召喚発動 (@s = beastmaster, at @s)

# CTセット (12秒 = 240tick)
scoreboard players set @s cd_beast_wolf 240

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 狼マーカー (armor_stand) 召喚 - 投げ禁止防止: invulnerable=1b, NoGravity:0b で重力あり
summon armor_stand ~ ~ ~ {Tags:["beast_wolf","new_wolf"],Invulnerable:1b,NoGravity:0b,Marker:0b,Small:0b,Invisible:1b,ShowArms:0b,NoBasePlate:1b,CustomName:'{"text":"狼","color":"gray","italic":false}',CustomNameVisible:1b,ArmorItems:[{},{},{},{id:"minecraft:wolf_head",count:1}]}

# IDと寿命/タイマー設定
execute as @e[tag=new_wolf,limit=1] run scoreboard players operation @s player_id = #TEMP player_id
execute as @e[tag=new_wolf,limit=1] run scoreboard players set @s gadget_life 300
execute as @e[tag=new_wolf,limit=1] run scoreboard players set @s wolf_attack_timer 0
tag @e[tag=new_wolf] remove new_wolf

# 演出
playsound minecraft:entity.wolf.howl master @a ~ ~ ~ 1.5 0.8
playsound minecraft:entity.wolf.growl master @a ~ ~ ~ 1.2 1.2
particle minecraft:cloud ~ ~0.5 ~ 0.3 0.2 0.3 0.1 15 force
particle minecraft:dust{color:[0.6,0.6,0.6],scale:1.0} ~ ~1 ~ 0.4 0.4 0.4 0 20 force

tellraw @s [{"text":"[狼] ","color":"gray","bold":true},{"text":"我が獣、駆け出せ！","color":"yellow"}]
