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

# Rush Mode Safety (ラッシュ中にCT0なのにアイテム無い場合は即時再配布)
execute as @s[tag=rush_mode,scores={cd_shield_bash=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_shield:1b}}}]}] run item replace entity @s container.2 with minecraft:paper[minecraft:custom_model_data={floats:[1.0]},minecraft:custom_data={tank_shield:1b},minecraft:custom_name='{"text":"シールドバッシュ","color":"blue","bold":true}',minecraft:lore=['{"text":"[Q]キーでドロップして突進 (2s)","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={},minecraft:item_model=shield] 1

# CT減少
scoreboard players remove @s[scores={cd_tank_crash=1..}] cd_tank_crash 1
scoreboard players remove @s[scores={cd_shield_bash=1..}] cd_shield_bash 1
execute if score @s cd_tank_crash matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# 4. スキル発動検知
# アースクラッシュ
# アースクラッシュ
execute if score @s click_tank matches 1.. run function my_pvp:roles/tank/use_crash
scoreboard players set @s click_tank 0

# アイテムのドロップ検知 (ハンマー・アースクラッシュの保護、シールドバッシュの発動)
function my_pvp:roles/tank/scan_items

# シールドバッシュ進行
execute if score @s shield_dash_timer matches 1.. run function my_pvp:roles/tank/shield_bash/tick

# --- 【新能力】 不屈の意志: HP25以下で耐性Lv2 + 再生 ---
execute store result score #HP temp run data get entity @s Health
execute if score #HP temp matches ..25 run effect give @s minecraft:resistance 1 1 true
# ※ 再生は「残り時間 % 間隔 == 0」の tick に回復するため、毎tick 1秒で付け直すと一度も回復しない。
#    効果が切れている時だけ5秒付与する (再生I = 2.5秒ごとに1回復)
execute if score #HP temp matches ..25 unless predicate my_pvp:has_regeneration run effect give @s minecraft:regeneration 5 0 true