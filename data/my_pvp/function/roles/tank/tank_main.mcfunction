# 1. パッシブ: 常時鈍足 + 常時耐性 (要塞化)
# Slowness 1 (-15% speed) と Resistance 1 (-20% dmg) を付与してタンクらしくする
effect give @s minecraft:slowness 1 0 true
effect give @s minecraft:resistance 1 0 true

# 2. UI表示 (変更なし)
# 2. UI表示
title @s actionbar [{"text":"Crash: ","color":"dark_green"},{"score":{"name":"@s","objective":"cd_tank_crash"},"color":"white"},{"text":" | Shield: ","color":"blue"},{"score":{"name":"@s","objective":"cd_shield_bash"},"color":"white"}]

# 3. クールダウン消化
scoreboard players remove @s[scores={cd_tank_crash=1..}] cd_tank_crash 1
scoreboard players remove @s[scores={cd_shield_bash=1..}] cd_shield_bash 1
execute if score @s cd_tank_crash matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_shield_bash matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# 4. スキル発動検知
# アースクラッシュ
execute if score @s click_tank matches 1.. run function my_pvp:roles/tank/use_crash
scoreboard players set @s click_tank 0

# シールドバッシュ (アイテムドロップ検知は scan_items で処理)
# バッシュ進行
execute if score @s shield_dash_timer matches 1.. run function my_pvp:roles/tank/shield_bash/tick
execute if score @s shield_dash_timer matches 1.. run function my_pvp:roles/tank/shield_bash/tick