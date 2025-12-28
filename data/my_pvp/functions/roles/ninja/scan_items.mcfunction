# 1. 所有者ID刻印 (忍者用アイテムのみ対象にする)
tag @e[type=item,tag=!id_set] remove target_item

# --- 対象アイテムをマーク ---
# 忍刀
execute as @e[type=item,tag=!id_set,nbt={Item:{tag:{ninja_sword:1b}}}] run tag @s add target_item
# 影縫い (黒染料)
execute as @e[type=item,tag=!id_set,nbt={Item:{id:"minecraft:black_dye"}}] run tag @s add target_item
# 煙玉 (木炭)
execute as @e[type=item,tag=!id_set,nbt={Item:{id:"minecraft:charcoal"}}] run tag @s add target_item
# 変わり身の杖 (一括指定)
execute as @e[type=item,tag=!id_set,nbt={Item:{id:"minecraft:carrot_on_a_stick"}}] run tag @s add target_item

# --- マークされたアイテムに対してのみ、近くの忍者のIDを付与 ---
# アイテムが出現した瞬間(プレイヤーの近く)にIDを記録します
execute as @e[tag=target_item] at @s if entity @p[tag=ninja,distance=..5] run scoreboard players operation @s player_id = @p[tag=ninja,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理関数の呼び出し
# 忍刀 -> process_sword
execute as @e[type=item,nbt={Item:{tag:{ninja_sword:1b}}}] at @s run function my_pvp:roles/ninja/process_sword

# 影縫い -> process_mark
execute as @e[type=item,nbt={Item:{id:"minecraft:black_dye"}}] at @s run function my_pvp:roles/ninja/process_mark

# 煙玉 -> process_smoke
execute as @e[type=item,nbt={Item:{id:"minecraft:charcoal"}}] at @s run function my_pvp:roles/ninja/process_smoke

# 変わり身の杖 -> process_rod (ドロップ時)
execute as @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}}] at @s run function my_pvp:roles/ninja/process_rod