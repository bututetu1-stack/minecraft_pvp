# 1. 持ち主の特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=chrono] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 2. CT中: 即時返却 (誤操作対策)
execute as @a[tag=item_recipient,scores={cd_chrono_stasis=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{chrono_stasis:1b}}}]}] run give @s minecraft:yellow_dye[minecraft:custom_data={chrono_stasis:1b},minecraft:custom_name='{"text":"|| 時空の静止","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1
execute as @a[tag=item_recipient,scores={cd_chrono_stasis=1..}] run title @s actionbar {"text":"Stasis Not Ready!","color":"red"}
execute as @a[tag=item_recipient,scores={cd_chrono_stasis=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

# 3. CTゼロ: スキル試行 (バーサーカーパターン: アイテムは返却せず CT終了時に自動返却)
execute as @a[tag=item_recipient,scores={cd_chrono_stasis=..0}] at @s run function my_pvp:roles/chrono/use_stasis

# 4. 後始末
tag @a remove item_recipient
kill @s
