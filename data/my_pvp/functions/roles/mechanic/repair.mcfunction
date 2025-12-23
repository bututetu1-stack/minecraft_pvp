# ガジェットの体力を最大値（10.0）まで回復させる
data modify entity @s Health set value 10.0f

# 演出：火花と金属を叩く音
particle minecraft:crit ~ ~0.5 ~ 0.2 0.2 0.2 0.1 5
playsound minecraft:block.anvil.place ambient @p ~ ~ ~ 0.3 2.0