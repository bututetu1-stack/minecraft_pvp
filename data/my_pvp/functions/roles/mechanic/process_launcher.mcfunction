# 1. アイテム保護（無敵化）
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、変更なし ---
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process
execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:piston{display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}'}} 1

tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_launcher=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_launcher=0,scrap=3..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_launcher=0,scrap=..2}] run tag @s add no_money

execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_launcher 100
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_launcher

execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

execute if entity @s[tag=can_process] as @e[tag=launcher,limit=1,sort=nearest] at @s if entity @p[tag=mechanic,distance=..1.5] run function my_pvp:roles/mechanic/launcher_trigger

execute if entity @s[tag=can_process] run kill @s