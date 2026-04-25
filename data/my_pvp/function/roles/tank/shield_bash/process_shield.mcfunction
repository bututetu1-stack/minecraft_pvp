# Process Shield Drop
# @s = item entity

# 1. 所有者を特定 (player_id 一致)
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=tank] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 2. CT中はアイテムを即時返却して終了 (誤操作対策、スキル発動なし)
execute as @a[tag=item_recipient,scores={cd_shield_bash=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{tank_shield:1b}}}]}] run give @s minecraft:paper[minecraft:custom_model_data={floats:[1.0]},minecraft:custom_data={tank_shield:1b},minecraft:custom_name='{"text":"シールドバッシュ","color":"blue","bold":true}',minecraft:lore=['{"text":"[Q]キーでドロップして突進 (2s)","color":"gray"}','{"text":"CT: 10s","color":"aqua"}'],minecraft:unbreakable={},minecraft:item_model=shield] 1
execute as @a[tag=item_recipient,scores={cd_shield_bash=1..}] run title @s actionbar {"text":"Shield Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_shield_bash=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# 3. CTが0ならスキル発動 (バーサーカーパターン: アイテムは返却せず CT終了時に tank_main で自動返却)
execute as @a[tag=item_recipient,scores={cd_shield_bash=..0}] at @s run function my_pvp:roles/tank/shield_bash/start

# 4. 後始末
tag @a remove item_recipient
kill @s
