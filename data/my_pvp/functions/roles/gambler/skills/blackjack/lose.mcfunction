# 敗北
# @s = player

tellraw @s {"text":"[BJ] LOSE... (敗北)","color":"gray","bold":true}

# 効果: 弱体化 I & 被ダメージ1.2倍 (10秒)

effect give @s minecraft:weakness 10 0 true
tag @s add bj_debuff
scoreboard players set @s bj_debuff_timer 200

tellraw @s {"text":"[BJ] 防御態勢が崩れた (被ダメージ増加)","color":"red"}
