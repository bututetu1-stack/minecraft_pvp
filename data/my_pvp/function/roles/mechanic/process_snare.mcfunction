# 1-3. 前処理
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# 【修正】コスト判定 8 -> 16
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=0,scrap=16..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=0},tag=rush_mode] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={cd_snare=0,scrap=..15},tag=!rush_mode] run tag @s add no_money

# --- 分岐実行 ---
# 成功時
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_snare 300
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_snare

# 失敗時
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# 【修正】Slot 3 に強制返却 (Cost表示 8 -> 16)
execute if entity @s[tag=can_process] as @p[tag=on_cd] run item replace entity @s container.3 with minecraft:compass[custom_name='{"text":"重力スネア","italic":false,"color":"light_purple"}',lore=['{"text":"Cost: 16 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:4b}] 1
execute if entity @s[tag=can_process] as @p[tag=no_money] run item replace entity @s container.3 with minecraft:compass[custom_name='{"text":"重力スネア","italic":false,"color":"light_purple"}',lore=['{"text":"Cost: 16 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:4b}] 1

# アイテム消去
execute if entity @s[tag=can_process] run kill @s