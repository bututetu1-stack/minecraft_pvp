# 1-4. 前処理
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# 【修正】コスト判定 5 -> 4
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=0,scrap=4..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_mine=0,scrap=..3}] run tag @s add no_money

# --- 実行処理 ---
# 成功時
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_mine 60
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_mine

# 失敗時
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# 【修正】Slot 1 に強制返却 (Cost表示 5 -> 4)
execute if entity @s[tag=can_process] as @p[tag=on_cd] run item replace entity @s container.1 with minecraft:iron_trapdoor{is_gadget:1b,gadget_type:2b,display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 4 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1
execute if entity @s[tag=can_process] as @p[tag=no_money] run item replace entity @s container.1 with minecraft:iron_trapdoor{is_gadget:1b,gadget_type:2b,display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 4 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# アイテム消去
execute if entity @s[tag=can_process] run kill @s