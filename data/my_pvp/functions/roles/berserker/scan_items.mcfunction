# 1. 所有者ID刻印
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=berserker,distance=..3] run scoreboard players operation @s player_id = @p[tag=berserker,limit=1,sort=nearest] player_id
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 2. アイテム処理

# ブラッドアックス (誤って捨てた場合の即時回収)
execute as @e[type=item,nbt={Item:{tag:{berserker_axe:1b}}}] at @s run function my_pvp:roles/berserker/process_axe

# ブラッドクリスタル (赤染料 -> スキル発動)
execute as @e[type=item,nbt={Item:{tag:{berserker_raid:1b}}}] at @s run function my_pvp:roles/berserker/process_raid

# リープフェザー (移動スキル)
execute as @e[type=item,nbt={Item:{tag:{berserker_jump:1b}}}] at @s run function my_pvp:roles/berserker/process_feather