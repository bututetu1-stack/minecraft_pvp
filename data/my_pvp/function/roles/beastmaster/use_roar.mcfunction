# 獣の咆哮発動

# CTセット (18秒 = 360tick)
scoreboard players set @s cd_beast_roar 360

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 自分に強化 (5秒 strength I + speed I)
effect give @s minecraft:strength 5 0 true
effect give @s minecraft:speed 5 0 true

# 召喚獣にも (寿命+100tick = 5秒延長 + 速度感のため tp で位置調整なし、効果は視覚のみ)
# 全召喚獣の寿命を最低100に底上げ
execute as @e[tag=beast_wolf] if score @s player_id = #TEMP player_id if score @s gadget_life matches ..99 run scoreboard players set @s gadget_life 100
# 召喚獣にも視覚演出
execute as @e[tag=beast_wolf] if score @s player_id = #TEMP player_id at @s run particle minecraft:dust{color:[1.0,0.9,0.0],scale:1.2} ~ ~1 ~ 0.4 0.4 0.4 0 12 force

# 演出
playsound minecraft:entity.wolf.howl master @a ~ ~ ~ 2 0.6
playsound minecraft:entity.warden.roar master @a ~ ~ ~ 1.5 1.5
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
particle minecraft:dust{color:[1.0,0.9,0.0],scale:1.5} ~ ~1 ~ 0.6 0.6 0.6 0 30 force
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1 force

tellraw @s [{"text":"[咆哮] ","color":"yellow","bold":true},{"text":"獣たちよ、力を込めよ！","color":"gold"}]
