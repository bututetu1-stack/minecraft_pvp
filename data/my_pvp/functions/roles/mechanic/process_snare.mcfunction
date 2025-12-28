# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、着地後の処理 ---
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# --- 状態チェック ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# A. CT中
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=1..}] run tag @s add on_cd
# B. OK
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=0,scrap=6..}] run tag @s add is_ready
# C. 金欠
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=0,scrap=..5}] run tag @s add no_money

# --- 分岐実行 ---
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_snare 300
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_snare

execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

execute if entity @s[tag=can_process] run kill @s