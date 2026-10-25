# 急降下中の毎tick処理
# @s = berserker (at @s)

effect clear @s minecraft:levitation
particle minecraft:cloud ~ ~1 ~ 0.2 0.3 0.2 0.02 3

# 下に十分な空間があれば一気に降下 (1tick 1.5ブロック)。地面が近づいたら通常の落下で着地する
execute if block ~ ~-0.5 ~ #my_pvp:dash_passable if block ~ ~-1.5 ~ #my_pvp:dash_passable run tp @s ~ ~-1.5 ~
