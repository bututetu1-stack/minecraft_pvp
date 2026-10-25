# 解き放つ: バーサーカーパターン
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=beastmaster] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# CT中: 即時返却
execute as @a[tag=item_recipient,scores={cd_beast_unleash=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_unleash:1b}}}]}] run give @s minecraft:redstone[minecraft:custom_data={beast_unleash:1b},minecraft:custom_name='{"text":"解き放つ","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 全召喚獣を即時自爆","color":"yellow"}','{"text":"各位置で半径3 damage 5 + KB","color":"gray"}','{"text":"CT: 20s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_beast_unleash=1..}] run title @s actionbar {"text":"解き放つ Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_beast_unleash=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# CTゼロ: 発動
execute as @a[tag=item_recipient,scores={cd_beast_unleash=..0}] at @s run function my_pvp:roles/beastmaster/use_unleash

tag @a remove item_recipient
kill @s
