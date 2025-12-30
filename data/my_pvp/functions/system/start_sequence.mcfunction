# 1. 試合開始フラグON
scoreboard players set #GLOBAL match_state 1
scoreboard players set #GLOBAL match_timer 0

# 2. 開始アナウンス
title @a title {"text":"GAME START!","color":"red","bold":true}

# 役職ごとのサブタイトル
execute as @a[tag=mechanic] run title @s subtitle {"text":"ガジェットを駆使して戦場を支配せよ","color":"gold"}
execute as @a[tag=ninja] run title @s subtitle {"text":"変幻自在の忍術で敵を翻弄せよ","color":"dark_purple"}
execute as @a[tag=scout] run title @s subtitle {"text":"ワイヤーを操り、戦場を縦横無尽に駆け巡れ","color":"aqua"}
execute as @a[tag=tank] run title @s subtitle {"text":"歩く要塞となり、戦場を蹂躙せよ","color":"dark_green"}
execute as @a[tag=berserker] run title @s subtitle {"text":"血を捧げ、敵を粉砕せよ","color":"red"}
execute as @a[tag=stalker] run title @s subtitle {"text":"執念深く獲物を追い詰め、息の根を止めよ","color":"dark_red"}
execute as @a[tag=admiral] run title @s subtitle {"text":"全艦隊指揮、圧倒的火力で制圧せよ","color":"dark_aqua"}

# 音とログ
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 1 1
tellraw @a [{"text":"[System] ","color":"gray"},{"text":"試合開始！","color":"green"}]

# --- 3. アイテム配布 (ここで一斉に武装) ---
execute as @a[tag=mechanic] run function my_pvp:system/give_mechanic_items
execute as @a[tag=ninja] run function my_pvp:system/give_ninja_items
execute as @a[tag=scout] run function my_pvp:system/give_scout_items
execute as @a[tag=tank] run function my_pvp:system/give_tank_items
execute as @a[tag=berserker] run function my_pvp:system/give_berserker_items
execute as @a[tag=stalker] run function my_pvp:system/give_stalker_items
execute as @a[tag=admiral] run function my_pvp:system/give_admiral_items