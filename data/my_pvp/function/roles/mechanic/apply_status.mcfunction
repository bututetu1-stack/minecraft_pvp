# 最大体力を40に設定
attribute @s minecraft:generic.max_health base set 40

# 全回復
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true

# 【追加】 デス後の復帰時にスクラップを50個支給
scoreboard players set @s scrap 50