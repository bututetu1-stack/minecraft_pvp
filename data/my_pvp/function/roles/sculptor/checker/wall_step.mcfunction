# wall_step - 壁チェック判定
execute unless block ~ ~ ~ #my_pvp:transparent run return 0
execute if entity @e[tag=target_hitbox,dx=0,limit=1] run function my_pvp:roles/sculptor/checker/success_hit
execute if entity @e[tag=target_hitbox,dx=0,limit=1] run return 0
function my_pvp:roles/sculptor/checker/wall_loop
