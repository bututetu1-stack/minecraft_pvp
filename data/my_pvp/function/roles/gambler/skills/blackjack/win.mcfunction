# 通常勝利
# @s = player

tellraw @s {"text":"[BJ] WIN! (勝利)","color":"gold","bold":true}

# HP上限回復 & 全回復
tag @s remove bj_debuff
# プレイヤーのHealthはdataコマンドで変更できないため、属性とエフェクトを使用
attribute @s minecraft:max_health base set 40
effect give @s minecraft:instant_health 1 255 true

# 効果: 攻撃力上昇II & 移動速度上昇II (10秒)
effect give @s minecraft:strength 10 1 true
effect give @s minecraft:speed 10 1 true
