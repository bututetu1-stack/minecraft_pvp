# 1-5. 前処理
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
tag @s remove can_spawn
execute if entity @s[nbt={OnGround:1b}] run tag @s add can_spawn
execute if entity @s[nbt={Motion:[0.0,0.0,0.0]}] run tag @s add can_spawn
execute unless entity @s[tag=can_spawn] run return 0
tag @a remove current_caster
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=mechanic] if score @s player_id = #TEMP player_id run tag @s add current_caster
tag @s remove can_process
execute if entity @p[tag=current_caster,distance=..300] run tag @s add can_process
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# 【修正】コスト判定 5 -> 10
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=0,scrap=10..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=0},tag=rush_mode] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=0,scrap=..9},tag=!rush_mode] run tag @s add no_money

# --- 6. 実行処理 ---
# 成功時
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_launcher

# 失敗時
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# 【修正】Slot 2 に強制返却 (Cost表示 5 -> 10)
execute if entity @s[tag=can_process] as @p[tag=on_cd] run item replace entity @s container.2 with minecraft:piston[custom_name='{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',lore=['{"text":"Cost: 10 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:3b}] 1
execute if entity @s[tag=can_process] as @p[tag=no_money] run item replace entity @s container.2 with minecraft:piston[custom_name='{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',lore=['{"text":"Cost: 10 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:3b}] 1

# アイテム消去
execute if entity @s[tag=can_process] run kill @s