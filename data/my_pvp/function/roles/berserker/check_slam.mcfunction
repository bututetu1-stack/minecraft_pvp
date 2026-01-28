# --- 1. 離陸検知 (Takeoff Check) ---
# 準備中(ber_ready) かつ 空中に浮いた(OnGround:0b) なら、落下待ちモード(ber_falling)に移行
# これにより、ジャンプ直後の誤作動を防ぐ

execute if entity @s[tag=ber_ready] unless entity @s[nbt={OnGround:1b}] run tag @s add ber_falling
execute if entity @s[tag=ber_falling] run tag @s remove ber_ready

# --- 2. 着地検知 (Landing Check) ---
# 落下待ちモード(ber_falling) かつ 地面に触れた(OnGround:1b) なら、攻撃発動
execute if entity @s[tag=ber_falling,nbt={OnGround:1b}] run function my_pvp:roles/berserker/slam_impact

# 攻撃したらタグを消して終了
execute if entity @s[tag=ber_falling,nbt={OnGround:1b}] run tag @s remove ber_falling