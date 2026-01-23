# 通常勝利
# @s = player

tellraw @s {"text":"[BJ] WIN! (勝利)","color":"gold","bold":true}

# 効果: 攻撃力上昇II & 移動速度上昇II (10秒)
effect give @s minecraft:strength 10 1 true
effect give @s minecraft:speed 10 1 true
