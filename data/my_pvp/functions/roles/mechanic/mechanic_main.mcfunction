# 1. 攻撃無効化
effect give @s minecraft:weakness 2 255 true

# 2. スクラップ配布
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp = #GLOBAL match_timer
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp %= #100 temp
execute if score @s temp matches 0 run scoreboard players add @s scrap 1

# 3. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# --- クールダウン完了通知 ---
execute as @s[scores={cd_turret=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2.0
execute as @s[scores={cd_mine=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2.0
execute as @s[scores={cd_launcher=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2.0
# 【追加】スネア通知
execute as @s[scores={cd_snare=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2.0

# 4. 設置クールダウンの消化
scoreboard players remove @s[scores={cd_turret=1..}] cd_turret 1
scoreboard players remove @s[scores={cd_mine=1..}] cd_mine 1
scoreboard players remove @s[scores={cd_launcher=1..}] cd_launcher 1
# 【追加】スネア消化
scoreboard players remove @s[scores={cd_snare=1..}] cd_snare 1

# スコア初期化
execute unless score @s cd_turret matches 0.. run scoreboard players set @s cd_turret 0
execute unless score @s cd_mine matches 0.. run scoreboard players set @s cd_mine 0
execute unless score @s cd_launcher matches 0.. run scoreboard players set @s cd_launcher 0
execute unless score @s cd_snare matches 0.. run scoreboard players set @s cd_snare 0

# 5. レンチ検知
execute as @s[predicate=my_pvp:is_sneaking,nbt={SelectedItem:{id:"minecraft:iron_axe"}}] run function my_pvp:roles/mechanic/wrench_check