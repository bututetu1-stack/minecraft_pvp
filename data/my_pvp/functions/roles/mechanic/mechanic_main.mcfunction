# 1. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 2. スクラップ配布 (5秒ごとに1増加)
scoreboard players operation @s temp = #GLOBAL match_timer
scoreboard players operation @s temp %= #100 temp
execute if score @s temp matches 0 if score #GLOBAL match_timer matches 1.. run scoreboard players add @s scrap 1

# スクラップ上限(100)
execute if score @s scrap matches 101.. run scoreboard players set @s scrap 100

# 3. クールダウン消化 & アイテム返却 (スロット固定)

# タレット (Slot 0)
execute as @s[scores={cd_turret=1}] run item replace entity @s container.0 with minecraft:redstone_torch{is_gadget:1b,gadget_type:1b,display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}',Lore:['{"text":"Cost: 5 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']}} 1
execute as @s[scores={cd_turret=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_turret=1..}] cd_turret 1

# 地雷 (Slot 1)
execute as @s[scores={cd_mine=1}] run item replace entity @s container.1 with minecraft:iron_trapdoor{is_gadget:1b,gadget_type:2b,display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 2 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1
execute as @s[scores={cd_mine=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_mine=1..}] cd_mine 1

# ランチャー (Slot 2)
execute as @s[scores={cd_launcher=1}] run item replace entity @s container.2 with minecraft:piston{is_gadget:1b,gadget_type:3b,display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 3 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']}} 1
execute as @s[scores={cd_launcher=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_launcher=1..}] cd_launcher 1

# スネア (Slot 3)
execute as @s[scores={cd_snare=1}] run item replace entity @s container.3 with minecraft:compass{is_gadget:1b,gadget_type:4b,display:{Name:'{"text":"重力スネア","italic":false,"color":"light_purple"}',Lore:['{"text":"Cost: 6 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1
execute as @s[scores={cd_snare=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_snare=1..}] cd_snare 1

# 4. レンチ操作検知
execute as @e[tag=gadget_hitbox,distance=..4] if data entity @s interaction run function my_pvp:roles/mechanic/wrench_click