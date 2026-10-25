# 1. 所有者ID刻印 (獣使い用アイテムのみ)
tag @e[type=item,tag=!id_set] remove target_item

# 対象アイテムをマーク
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{beast_whip:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{beast_wolf:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{beast_roar:1b}] run tag @s add target_item
execute as @e[type=item,tag=!id_set] if items entity @s contents *[minecraft:custom_data~{beast_unleash:1b}] run tag @s add target_item

# 近距離(半径15)の獣使いから player_id を継承
execute as @e[tag=target_item] at @s if entity @p[tag=beastmaster,distance=..15] run scoreboard players operation @s player_id = @p[tag=beastmaster,limit=1,sort=nearest] player_id

# ID設定完了タグ
execute as @e[tag=target_item] if score @s player_id matches 1.. run tag @s add id_set

# 後始末
tag @e[tag=target_item] remove target_item


# 2. アイテム処理 (id_set 必須)
# 鞭 (投げ禁止 → 即時返却)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{beast_whip:1b}] at @s run function my_pvp:roles/beastmaster/process_whip
# 狼の召喚 (発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{beast_wolf:1b}] at @s run function my_pvp:roles/beastmaster/process_wolf
# 獣の咆哮 (発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{beast_roar:1b}] at @s run function my_pvp:roles/beastmaster/process_roar
# 解き放つ (発動)
execute as @e[type=item,tag=id_set] if items entity @s contents *[minecraft:custom_data~{beast_unleash:1b}] at @s run function my_pvp:roles/beastmaster/process_unleash
