# 1. パッシブ: 常時鈍足 (重装備感)
effect give @s minecraft:slowness 1 0 true

# 2. UI表示 (クールダウン表示に変更)
title @s actionbar [{"text":"Crash: ","color":"dark_green"},{"score":{"name":"@s","objective":"cd_tank_crash"},"color":"white"}]

# 3. クールダウン消化
scoreboard players remove @s[scores={cd_tank_crash=1..}] cd_tank_crash 1
execute if score @s cd_tank_crash matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# 4. スキル発動検知
execute if score @s click_tank matches 1.. run function my_pvp:roles/tank/use_crash
scoreboard players set @s click_tank 0