# 1. 所有者ID刻印
# 【修正】検知距離を 3 -> 6 に拡大 (移動投げ対策)
execute as @e[type=item,tag=!id_set] at @s if entity @p[tag=berserker,distance=..6] run scoreboard players operation @s player_id = @p[tag=berserker,limit=1,sort=nearest] player_id

# ID付与成功時のみフラグを立てる
execute as @e[type=item,tag=!id_set] if score @s player_id matches 1.. run tag @s add id_set

# 2. アイテム処理
# 【修正】tag=id_set を条件に追加 (ID未付与のまま処理関数に入り、所有者不明で消えるのを防ぐ)

# ブラッドアックス (誤って捨てた場合の即時回収)
execute as @e[type=item,tag=id_set,nbt={Item:{tag:{berserker_axe:1b}}}] at @s run function my_pvp:roles/berserker/process_axe

# ブラッドクリスタル (赤染料 -> スキル発動)
execute as @e[type=item,tag=id_set,nbt={Item:{tag:{berserker_raid:1b}}}] at @s run function my_pvp:roles/berserker/process_raid

# リープフェザー (移動スキル)
execute as @e[type=item,tag=id_set,nbt={Item:{tag:{berserker_jump:1b}}}] at @s run function my_pvp:roles/berserker/process_feather