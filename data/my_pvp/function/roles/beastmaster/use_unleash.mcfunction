# 解き放つ発動 - 全召喚獣を即時自爆

# CTセット (20秒 = 400tick)
scoreboard players set @s cd_beast_unleash 400

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 全自分召喚獣で爆発処理
execute as @e[tag=beast_wolf] if score @s player_id = #TEMP player_id at @s run function my_pvp:roles/beastmaster/wolf_explode

# 演出
playsound minecraft:entity.wolf.howl master @a ~ ~ ~ 2 0.5
tellraw @s [{"text":"[解き放つ] ","color":"red","bold":true},{"text":"獣の絆を爆ぜさせる","color":"yellow"}]
