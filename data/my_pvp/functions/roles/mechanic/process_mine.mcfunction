# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、着地後の処理 ---
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# --- 状態チェックと実行 ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=1..}] run tag @s add on_cd
# コスト5以上
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=0,scrap=5..}] run tag @s add is_ready
# コスト4以下
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=0,scrap=..4}] run tag @s add no_money

execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_mine 60
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_mine

execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

execute if entity @s[tag=can_process] run kill @s