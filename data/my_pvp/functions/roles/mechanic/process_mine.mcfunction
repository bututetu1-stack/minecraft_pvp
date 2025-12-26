# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、着地後の処理 ---
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# 【変更】LoreにCT表記を追加
execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:iron_trapdoor{display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 2 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# --- 状態チェックと実行 ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=0,scrap=2..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=0,scrap=..1}] run tag @s add no_money

execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_mine 60
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_mine

execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

execute if entity @s[tag=can_process] run kill @s