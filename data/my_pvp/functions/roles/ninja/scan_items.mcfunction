# 1. アイテムに所有者IDを刻印 (投げた瞬間に確定)
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=ninja,distance=..3] run scoreboard players operation @s player_id = @p[tag=ninja,limit=1,sort=nearest] player_id

# IDが正常に付与されたらタグ付け
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 2. 各アイテム処理
# 影縫い (黒染料)
execute as @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}] at @s run function my_pvp:roles/ninja/process_mark

# 煙玉 (木炭)
execute as @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}] at @s run function my_pvp:roles/ninja/process_smoke

# 忍刀
execute as @e[type=item,nbt={Item:{tag:{ninja_sword:1b}}}] at @s run function my_pvp:roles/ninja/process_sword

# 変わり身の杖 (即時回収)
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}}] at @s run function my_pvp:roles/ninja/process_rod