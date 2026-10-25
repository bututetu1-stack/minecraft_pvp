# 獣の咆哮: バーサーカーパターン
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=beastmaster] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# CT中: 即時返却
execute as @a[tag=item_recipient,scores={cd_beast_roar=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_roar:1b}}}]}] run give @s minecraft:ghast_tear[minecraft:custom_data={beast_roar:1b},minecraft:custom_name='{"text":"獣の咆哮","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分+召喚獣に強化 5秒","color":"yellow"}','{"text":"strength I + speed I","color":"gray"}','{"text":"CT: 18s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_beast_roar=1..}] run title @s actionbar {"text":"咆哮 Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_beast_roar=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# CTゼロ: 発動
execute as @a[tag=item_recipient,scores={cd_beast_roar=..0}] at @s run function my_pvp:roles/beastmaster/use_roar

tag @a remove item_recipient
kill @s
