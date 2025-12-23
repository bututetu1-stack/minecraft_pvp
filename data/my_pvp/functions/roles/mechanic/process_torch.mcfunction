# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、着地後の処理 ---
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# 【変更】LoreにCT表記を追加
execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:redstone_torch{display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}',Lore:['{"text":"Cost: 5 SCRAP","color":"gray"}','{"text":"CoolDown: 5s","color":"aqua"}']}} 1

# --- 状態チェックと実行 ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_turret=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_turret=0,scrap=5..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_turret=0,scrap=..4}] run tag @s add no_money

execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_turret 100
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_sentry

execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

execute if entity @s[tag=can_process] run kill @s