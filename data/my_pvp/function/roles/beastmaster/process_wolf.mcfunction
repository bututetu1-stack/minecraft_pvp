# 狼の召喚: バーサーカーパターン
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=beastmaster] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# CT中: 即時返却
execute as @a[tag=item_recipient,scores={cd_beast_wolf=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_wolf:1b}}}]}] run give @s minecraft:bone[minecraft:custom_data={beast_wolf:1b},minecraft:custom_name='{"text":"狼の呼び声","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 狼を召喚 (最大2匹)","color":"yellow"}','{"text":"接触で damage 2/sec, 15秒消滅","color":"gray"}','{"text":"CT: 12s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_beast_wolf=1..}] run title @s actionbar {"text":"狼 Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_beast_wolf=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# 召喚上限チェック (5匹まで)
execute as @a[tag=item_recipient,scores={cd_beast_wolf=..0,wolf_count=5..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_wolf:1b}}}]}] run give @s minecraft:bone[minecraft:custom_data={beast_wolf:1b},minecraft:custom_name='{"text":"狼の呼び声","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 狼を召喚 (最大5匹)","color":"yellow"}','{"text":"接触で damage 2/sec, 永続","color":"gray"}','{"text":"CT: 12s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_beast_wolf=..0,wolf_count=5..}] run title @s actionbar {"text":"召喚上限 (5/5)","color":"red"}

# 召喚可能: 発動
execute as @a[tag=item_recipient,scores={cd_beast_wolf=..0,wolf_count=..4}] at @s run function my_pvp:roles/beastmaster/use_wolf

tag @a remove item_recipient
kill @s
