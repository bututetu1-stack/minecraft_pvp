#タレット攻撃
execute at @s as @a[distance=0.1..7] unless score @s player_id = @e[tag=gadget,limit=1,sort=nearest,distance=..1] player_id run function my_pvp:roles/mechanic/sentry_attack

# 透明な地雷（mine）に敵（IDが一致しない者）が1.5マス以内に来たら爆発
execute as @e[tag=mine] at @s as @a[distance=..1.5] unless score @s player_id = @e[tag=mine,limit=1,sort=nearest,distance=..1] player_id run function my_pvp:roles/mechanic/mine_explode

# 半径1.2マス以内に誰か（自分含む全員）が来たら発動
execute as @e[tag=launcher] at @s if entity @a[distance=..1.2] run function my_pvp:roles/mechanic/launcher_trigger