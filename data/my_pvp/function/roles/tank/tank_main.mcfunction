# 1. パッシブ: 常時鈍足 + 常時耐性 (要塞化)
# Slowness 1 (-15% speed) と Resistance 1 (-20% dmg) を付与してタンクらしくする
effect give @s minecraft:slowness 1 0 true
effect give @s minecraft:resistance 1 0 true

# 2. UI表示 (変更なし)
# 2. UI表示
title @s actionbar [{"text":"Crash: ","color":"dark_green"},{"score":{"name":"@s","objective":"cd_tank_crash"},"color":"white"},{"text":" | Shield: ","color":"blue"},{"score":{"name":"@s","objective":"cd_shield_bash"},"color":"white"}]

# 3. クールダウン消化 & アイテム返却 (バーサーカーパターン)
# シールドバッシュ (paper) - CT終了時に自動返却
execute as @s[scores={cd_shield_bash=1}] run item replace entity @s container.2 with minecraft:paper[minecraft:custom_model_data={floats:[1.0]},minecraft:custom_data={tank_shield:1b},minecraft:custom_name='{"text":"シールドバッシュ","color":"blue","bold":true}',minecraft:lore=['{"text":"[Q]キーでドロップして突進 (2s)","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={},minecraft:item_model=shield] 1
execute as @s[scores={cd_shield_bash=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# CT減少
scoreboard players remove @s[scores={cd_tank_crash=1..}] cd_tank_crash 1
scoreboard players remove @s[scores={cd_shield_bash=1..}] cd_shield_bash 1
execute if score @s cd_tank_crash matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# 4. スキル発動検知
# アースクラッシュ
# アースクラッシュ
execute if score @s click_tank matches 1.. run function my_pvp:roles/tank/use_crash
scoreboard players set @s click_tank 0

# シールドバッシュ (アイテムドロップ検知は scan_items で処理)
# バッシュ進行
execute if score @s shield_dash_timer matches 1.. run function my_pvp:roles/tank/shield_bash/tick

# アイテムスキャン (ドロップ感知)
function my_pvp:roles/tank/scan_items

# 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump

# --- 【新能力】 不屈の意志: HP25以下で耐性Lv2 + 再生 ---
execute store result score #HP temp run data get entity @s Health
execute if score #HP temp matches ..25 run effect give @s minecraft:resistance 1 1 true
execute if score #HP temp matches ..25 run effect give @s minecraft:regeneration 1 0 true