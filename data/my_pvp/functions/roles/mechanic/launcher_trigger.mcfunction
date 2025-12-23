# 判定範囲を元に戻す (..2.5 -> ..1.5)
execute as @a[distance=..1.5] run tp @s ~ ~1.2 ~

# 効果付与
execute as @a[distance=..1.5] run effect give @s minecraft:levitation 1 10 true
execute as @a[distance=..1.5] run effect give @s minecraft:speed 2 20 true

# 演出
playsound minecraft:block.piston.extend ambient @a ~ ~ ~ 1 1.2
particle minecraft:cloud ~ ~0.5 ~ 0.5 0.2 0.5 0.2 30

# 消去
kill @s