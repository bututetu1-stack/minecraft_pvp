# --- アクションバー ---
title @s actionbar [{"text":"Wolf: ","color":"gray"},{"score":{"name":"@s","objective":"cd_beast_wolf"},"color":"white"},{"text":" | Roar: ","color":"yellow"},{"score":{"name":"@s","objective":"cd_beast_roar"},"color":"white"},{"text":" | Unleash: ","color":"red"},{"score":{"name":"@s","objective":"cd_beast_unleash"},"color":"white"},{"text":" | 召喚:","color":"gray"},{"score":{"name":"@s","objective":"wolf_count"},"color":"yellow"},{"text":"/5","color":"gray"}]

# --- CT終了時のアイテム自動返却 (バーサーカーパターン) ---
# 狼の召喚 (slot 1)
execute as @s[scores={cd_beast_wolf=1}] run item replace entity @s container.1 with minecraft:bone[minecraft:custom_data={beast_wolf:1b},minecraft:custom_name='{"text":"狼の呼び声","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 狼を召喚 (最大5匹)","color":"yellow"}','{"text":"接触で damage 2/sec, 永続","color":"gray"}','{"text":"CT: 12s","color":"aqua"}']] 1
execute as @s[scores={cd_beast_wolf=1}] run playsound minecraft:entity.wolf.ambient master @s ~ ~ ~ 0.6 1.5

# 獣の咆哮 (slot 2)
execute as @s[scores={cd_beast_roar=1}] run item replace entity @s container.2 with minecraft:ghast_tear[minecraft:custom_data={beast_roar:1b},minecraft:custom_name='{"text":"獣の咆哮","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分+召喚獣に強化 5秒","color":"yellow"}','{"text":"strength I + speed I","color":"gray"}','{"text":"CT: 18s","color":"aqua"}']] 1
execute as @s[scores={cd_beast_roar=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 1.2

# 解き放つ (slot 3)
execute as @s[scores={cd_beast_unleash=1}] run item replace entity @s container.3 with minecraft:redstone[minecraft:custom_data={beast_unleash:1b},minecraft:custom_name='{"text":"解き放つ","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 全召喚獣を即時自爆","color":"yellow"}','{"text":"各位置で半径3 damage 5 + KB","color":"gray"}','{"text":"CT: 20s","color":"aqua"}']] 1
execute as @s[scores={cd_beast_unleash=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 0.8

# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_beast_wolf=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_wolf:1b}}}]}] run item replace entity @s container.1 with minecraft:bone[minecraft:custom_data={beast_wolf:1b},minecraft:custom_name='{"text":"狼の呼び声","color":"gray","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 狼を召喚 (最大5匹)","color":"yellow"}','{"text":"接触で damage 2/sec, 永続","color":"gray"}','{"text":"CT: 12s","color":"aqua"}']] 1
execute as @s[tag=rush_mode,scores={cd_beast_roar=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_roar:1b}}}]}] run item replace entity @s container.2 with minecraft:ghast_tear[minecraft:custom_data={beast_roar:1b},minecraft:custom_name='{"text":"獣の咆哮","color":"yellow","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 自分+召喚獣に強化 5秒","color":"yellow"}','{"text":"strength I + speed I","color":"gray"}','{"text":"CT: 18s","color":"aqua"}']] 1
execute as @s[tag=rush_mode,scores={cd_beast_unleash=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{beast_unleash:1b}}}]}] run item replace entity @s container.3 with minecraft:redstone[minecraft:custom_data={beast_unleash:1b},minecraft:custom_name='{"text":"解き放つ","color":"red","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 全召喚獣を即時自爆","color":"yellow"}','{"text":"各位置で半径3 damage 5 + KB","color":"gray"}','{"text":"CT: 20s","color":"aqua"}']] 1

# --- CT減少 ---
execute if score @s cd_beast_wolf matches 1.. run scoreboard players remove @s cd_beast_wolf 1
execute if score @s cd_beast_roar matches 1.. run scoreboard players remove @s cd_beast_roar 1
execute if score @s cd_beast_unleash matches 1.. run scoreboard players remove @s cd_beast_unleash 1

# --- 鞭の命中時slowness付与 (damage_dealt 検知) ---
execute unless score @s last_damage_dealt = @s damage_dealt at @s run function my_pvp:roles/beastmaster/check_whip_hit
execute unless score @s last_damage_dealt = @s damage_dealt run scoreboard players operation @s last_damage_dealt = @s damage_dealt

# --- 自分の召喚狼の数を更新 (#WOLF_COUNT temp 経由) ---
scoreboard players operation #BEAST_OWNER temp = @s player_id
scoreboard players set #WOLF_COUNT temp 0
execute as @e[tag=beast_wolf] if score @s player_id = #BEAST_OWNER temp run scoreboard players add #WOLF_COUNT temp 1
scoreboard players operation @s wolf_count = #WOLF_COUNT temp

# --- 役職固有 上昇スキル (sneak短) ---
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/beastmaster/use_jump

# --- アイテムスキャン ---
function my_pvp:roles/beastmaster/scan_items
