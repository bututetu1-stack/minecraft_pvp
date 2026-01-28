# Shield Bash Start
# @s = player

# Check Cooldown
execute if score @s cd_shield_bash matches 1.. run tellraw @s {"text":"[Tank] Not Ready...","color":"red"}
execute if score @s cd_shield_bash matches 1.. run return 0

# Start
tellraw @s {"text":"[Tank] Shield Bash!","color":"blue","bold":true}
scoreboard players set @s cd_shield_bash 200
scoreboard players set @s shield_dash_timer 40

# Summon guide marker (anchor)
# プレイヤーの向いている方向を固定するためのマーカーを召喚
tag @s add current_dasher
scoreboard players operation #TEMP player_id = @s player_id
summon marker ~ ~ ~ {Tags:["bash_guide"]}

# ID同期 (マーカーにPlayerIDを持たせる)
execute as @e[tag=bash_guide,limit=1,sort=nearest] run scoreboard players operation @s player_id = #TEMP player_id
# マーカーの向きをプレイヤーに合わせる (まずプレイヤーに向きを合わせ、その後ピッチを0にして水平固定)
execute as @e[tag=bash_guide,limit=1,sort=nearest] run tp @s @p[tag=current_dasher]
execute as @e[tag=bash_guide,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ ~ 0

# Effects
playsound minecraft:item.shield.block master @a ~ ~ ~ 1 0.5
playsound minecraft:entity.ender_dragon.flap master @a ~ ~ ~ 1 1.5

# Knockback Buff (For Tick Damage)
attribute @s minecraft:attack_knockback base set 5.0
