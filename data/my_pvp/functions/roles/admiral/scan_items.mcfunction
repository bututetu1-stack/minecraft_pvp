# 1. 所有者ID刻印
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
# 砲撃支援 (Slot 0)
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{adm_artillery:1b}}}] run tag @s add target_item
# 魚雷 (Slot 1)
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{adm_torpedo:1b}}}] run tag @s add target_item
# 航空支援 (Slot 2)
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{adm_air:1b}}}] run tag @s add target_item
# 対空 (Slot 3)
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{adm_aa:1b}}}] run tag @s add target_item

# マークされたアイテムに対してのみ、近くの提督のIDを付与
execute as @e[tag=target_item] at @s if entity @p[tag=admiral,distance=..15] run scoreboard players operation @s player_id = @p[tag=admiral,limit=1,sort=nearest] player_id

# ID設定完了タグ (プレイヤーIDを持っている場合のみ付与)
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理
# 【重要修正】 tag=id_set の条件を復活させました。
# これにより、ID付与に失敗したアイテムが消失するのを防ぎます。

execute as @e[type=item,tag=id_set,nbt={Item:{tag:{adm_artillery:1b}}}] at @s run function my_pvp:roles/admiral/process_artillery
execute as @e[type=item,tag=id_set,nbt={Item:{tag:{adm_torpedo:1b}}}] at @s run function my_pvp:roles/admiral/process_torpedo
execute as @e[type=item,tag=id_set,nbt={Item:{tag:{adm_air:1b}}}] at @s run function my_pvp:roles/admiral/process_air
execute as @e[type=item,tag=id_set,nbt={Item:{tag:{adm_aa:1b}}}] at @s run function my_pvp:roles/admiral/process_aa