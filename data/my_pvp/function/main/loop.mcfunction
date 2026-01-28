# 1. 試合進行（game_logicを呼び出す）
# 1. 試合進行（game_logicを呼び出す）
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic

# --- 【修正】定数・タイマーの強制初期化 (Global Scope) ---
execute unless score #4_CONST temp matches 4 run scoreboard players set #4_CONST temp 4
execute unless score #CONST_40 temp matches 40 run scoreboard players set #CONST_40 temp 40
execute unless score #CONST_10 temp matches 10 run scoreboard players set #CONST_10 temp 10
execute unless score #GLOBAL regen_timer matches 0.. run scoreboard players set #GLOBAL regen_timer 0

# --- 【修正】5秒毎にHP回復 (ロビー/試合中問わず動作) ---
scoreboard players add #GLOBAL regen_timer 1
# Debug Message (100tick毎)
# execute if score #GLOBAL regen_timer matches 100.. run tellraw @a {"text":"[System] Auto-Regen Triggered (2 HP)","color":"green"}
execute if score #GLOBAL regen_timer matches 100.. run effect give @a minecraft:regeneration 3 1 true
execute if score #GLOBAL regen_timer matches 100.. run scoreboard players set #GLOBAL regen_timer 0

# --- 死体処理タグのクリーンアップ ---
# 生きている(HP>0)プレイヤーからは処理済みタグを外す
execute as @a[tag=dead_processing] store result score #HP temp run data get entity @s Health
execute as @a[tag=dead_processing] if score #HP temp matches 1.. run tag @s remove dead_processing