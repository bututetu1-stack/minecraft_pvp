# 1. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 2. スクラップ配布 (1秒ごとに1増加)
scoreboard players set #20 temp 20
scoreboard players operation @s temp = #GLOBAL match_timer
scoreboard players operation @s temp %= #20 temp
execute if score @s temp matches 0 if score #GLOBAL match_timer matches 1.. run scoreboard players add @s scrap 1

# --- 【追加】キル時スクラップ獲得 (+30) ---
# バーサーカー同様、killsスコアの変動を検知して報酬を与えます
execute unless score @s last_kills = @s kills run scoreboard players add @s scrap 30
execute unless score @s last_kills = @s kills run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 2
# 検知用スコアを更新
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# スクラップ上限(100)
execute if score @s scrap matches 101.. run scoreboard players set @s scrap 100

# 3. クールダウン消化 & アイテム返却 (スロット固定)

# タレット (Slot 0)
execute as @s[scores={cd_turret=1}] run item replace entity @s container.0 with minecraft:redstone_torch[custom_name='{"text":"マイクロタレット","italic":false,"color":"gold"}',lore=['{"text":"Cost: 14 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:1b}] 1
execute as @s[scores={cd_turret=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_turret=1..}] cd_turret 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_turret=0}] unless entity @s[nbt={Inventory:[{Slot:0b,id:"minecraft:redstone_torch"}]}] run item replace entity @s container.0 with minecraft:redstone_torch[custom_name='{"text":"マイクロタレット","italic":false,"color":"gold"}',lore=['{"text":"Cost: 14 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:1b}] 1

# 地雷 (Slot 1)
execute as @s[scores={cd_mine=1}] run item replace entity @s container.1 with minecraft:iron_trapdoor[custom_name='{"text":"地雷","italic":false,"color":"gray"}',lore=['{"text":"Cost: 8 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:2b}] 1
execute as @s[scores={cd_mine=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_mine=1..}] cd_mine 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_mine=0}] unless entity @s[nbt={Inventory:[{Slot:1b,id:"minecraft:iron_trapdoor"}]}] run item replace entity @s container.1 with minecraft:iron_trapdoor[custom_name='{"text":"地雷","italic":false,"color":"gray"}',lore=['{"text":"Cost: 8 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:2b}] 1

# ランチャー (Slot 2)
execute as @s[scores={cd_launcher=1}] run item replace entity @s container.2 with minecraft:piston[custom_name='{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',lore=['{"text":"Cost: 10 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:3b}] 1
execute as @s[scores={cd_launcher=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_launcher=1..}] cd_launcher 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_launcher=0}] unless entity @s[nbt={Inventory:[{Slot:2b,id:"minecraft:piston"}]}] run item replace entity @s container.2 with minecraft:piston[custom_name='{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',lore=['{"text":"Cost: 10 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:3b}] 1

# スネア (Slot 3)
execute as @s[scores={cd_snare=1}] run item replace entity @s container.3 with minecraft:compass[custom_name='{"text":"重力スネア","italic":false,"color":"light_purple"}',lore=['{"text":"Cost: 16 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:4b}] 1
execute as @s[scores={cd_snare=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_snare=1..}] cd_snare 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_snare=0}] unless entity @s[nbt={Inventory:[{Slot:3b,id:"minecraft:compass"}]}] run item replace entity @s container.3 with minecraft:compass[custom_name='{"text":"重力スネア","italic":false,"color":"light_purple"}',lore=['{"text":"Cost: 16 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}'],custom_data={is_gadget:1b,gadget_type:4b}] 1

# 4. レンチ操作検知
execute as @e[tag=gadget_hitbox,distance=..4] if data entity @s interaction run function my_pvp:roles/mechanic/wrench_click