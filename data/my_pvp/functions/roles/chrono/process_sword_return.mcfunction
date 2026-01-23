# 刻の宝剣の返却処理
# @s = アイテム

# 1. アイテム保護
data merge entity @s {PickupDelay:0s,Invulnerable:1b}

# 2. 近くの時空跳躍者に強制的に渡す（tpで吸い寄せる）
execute at @s run tp @s @p[tag=chrono,distance=..10]

# 一定時間経過しても拾われないならkillするなどの処理が必要だが、
# tp @p でプレイヤーの足元に行くので拾われるはず
