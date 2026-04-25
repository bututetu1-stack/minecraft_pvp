# 居合発動
# CTチェック
execute if score @s cd_sam_iai matches 1.. run return 0

# CT設定 (10秒)
scoreboard players set @s cd_sam_iai 200

# 突進状態タグ (8tick = 0.4秒)
tag @s add sam_iai_dashing
scoreboard players set @s sam_iai_active 8

# 短時間の保護 (居合中はダメージ軽減)
effect give @s minecraft:resistance 1 2 true
effect give @s minecraft:speed 2 4 true

# 演出
particle minecraft:sweep_attack ~ ~1 ~ 0 0 0 0 3
playsound minecraft:item.trident.throw master @a ~ ~ ~ 1 1.5
tellraw @s [{"text":"[居合] ","color":"red","bold":true},{"text":"抜刀！","color":"yellow"}]
