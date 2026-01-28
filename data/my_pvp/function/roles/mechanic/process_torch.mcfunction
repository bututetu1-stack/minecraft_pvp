# 1-4. 前処理（変更なし）
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
tag @a remove current_caster
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=mechanic] if score @s player_id = #TEMP player_id run tag @s add current_caster
execute if entity @p[tag=current_caster,distance=..300] run tag @s add can_process
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# 【修正】コスト判定 7 -> 14
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=0,scrap=14..}] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=0},tag=rush_mode] run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=0,scrap=..13},tag=!rush_mode] run tag @s add no_money

# --- 5. 実行処理 ---
# 成功時
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_turret 100
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_sentry

# 失敗時：エラー表示 & アイテム返却 (Slot 0)
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# 【修正】Slot 0 に強制返却 (Cost表示 7 -> 14)
execute if entity @s[tag=can_process] as @p[tag=on_cd] run item replace entity @s container.0 with minecraft:redstone_torch[custom_name='{"text":"マイクロタレット","italic":false,"color":"gold"}',lore=['{"text":"Cost: 14 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:1b}] 1
execute if entity @s[tag=can_process] as @p[tag=no_money] run item replace entity @s container.0 with minecraft:redstone_torch[custom_name='{"text":"マイクロタレット","italic":false,"color":"gold"}',lore=['{"text":"Cost: 14 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:1b}] 1

# アイテム消去
execute if entity @s[tag=can_process] run kill @s