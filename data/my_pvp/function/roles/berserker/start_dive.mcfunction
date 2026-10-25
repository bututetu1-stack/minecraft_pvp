# 急降下 (Dive) 開始
# リープフェザーで跳んだ後 (ber_falling)、空中で Shift を押すと呼ばれる
# @s = berserker

# Shift 入力を消費 (大ジャンプに使わせない)
scoreboard players set @s sneak_time 0

# 急降下状態 (着地時の衝撃波が強化される / slam_impact で解除)
tag @s add ber_slamming
effect clear @s minecraft:levitation

# 演出
playsound minecraft:entity.ravager.roar master @a ~ ~ ~ 1 1.2
particle minecraft:crit ~ ~1 ~ 0.4 0.4 0.4 0.3 20
