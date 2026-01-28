# 通常勝利
# @s = player

tellraw @s {"text":"[BJ] WIN! (勝利)","color":"gold","bold":true}

# HP上限回復 & 全回復
function my_pvp:roles/gambler/skills/blackjack/restore_hp
tag @s remove bj_debuff
data modify entity @s Health set value 40.0f

# 効果: 攻撃力上昇II & 移動速度上昇II (10秒)
effect give @s minecraft:strength 10 1 true
effect give @s minecraft:speed 10 1 true
