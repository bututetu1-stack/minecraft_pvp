# 1. 少し上に浮かせて地面との摩擦を消す
execute as @a[distance=..1.5] run tp @s ~ ~1.2 ~

# 2. 斜め上に弾き飛ばすための「浮遊」と「加速」
# Levitation 255 は「重力を無視する」状態に近く、一瞬で上昇させます
execute as @a[distance=..1.5] run effect give @s minecraft:levitation 1 10 true
execute as @a[distance=..1.5] run effect give @s minecraft:speed 2 20 true

# 3. ピストンの動作音とパーティクル
playsound minecraft:block.piston.extend ambient @a ~ ~ ~ 1 1.2
particle minecraft:cloud ~ ~0.5 ~ 0.5 0.2 0.5 0.2 30

# 4. 一度発動したら少しクールタイムを置くか、使い捨てにするなら kill @s
# 今回は「使い捨て」にして、エンジニアが再度設置させるようにします
kill @s