# 壁チェック判定
# 1. ブロック判定
execute unless block ~ ~ ~ #my_pvp:transparent run return 0

# 2. ターゲット到達判定
# dx=0 で target_hitbox に当たれば成功
execute if entity @e[tag=target_hitbox,dx=0,limit=1] run function my_pvp:roles/sculptor/checker/success_hit

# Hitしたら終了 (success_hit内で return制御できないので、距離をMAXにして止める)
execute if entity @e[tag=target_hitbox,dx=0,limit=1] run scoreboard players set #RAY_DIST temp 100
execute if score #RAY_DIST temp matches 100 run return 0

# 3. 次のステップ
function my_pvp:roles/sculptor/checker/wall_loop
