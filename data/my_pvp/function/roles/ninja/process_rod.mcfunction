# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. ロジック実行
# 既存の handle_rod_drop は @e[type=item] に対して実行する設計なので、
# ここでは @s (アイテム自身) の場所で実行させる
execute at @s run function my_pvp:roles/ninja/handle_rod_drop

# 3. アイテム消去
# handle_rod_drop 内でも kill していますが、念のため
kill @s