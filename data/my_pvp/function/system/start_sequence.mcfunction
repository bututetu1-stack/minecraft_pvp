# 1. 試合開始フラグON
scoreboard players set #GLOBAL match_state 1
scoreboard players set #GLOBAL match_timer 0
scoreboard players set @a sneak_time 0

# 【追加】ゲーム中心点の設定 (game_startで設置済みだが念のため維持or削除)
# ここでは削除せず、既存のマーカーを使用
# kill @e[tag=game_center]
# summon marker ~ ~ ~ {Tags:["game_center"]}

# 【修正】全プレイヤーをランダム転送 (共通関数呼び出し)
execute as @a run function my_pvp:system/random_spawn

# 【追加】物理挙動の調整 (Gravity:0.105, Jump:0.6, Speed:1.1倍)
execute as @a run attribute @s minecraft:jump_strength base set 0.6
execute as @a run attribute @s minecraft:gravity base set 0.105
execute as @a run attribute @s minecraft:movement_speed base set 0.11

# 【修正】ノックバック力の異常対策 (初期値に戻す)
execute as @a run attribute @s minecraft:attack_knockback base set 0

# 2. 開始アナウンス
title @a title {"text":"GAME START!","color":"red","bold":true}

# 役職ごとのサブタイトル
execute as @a[tag=mechanic] run title @s subtitle {"text":"ガジェットを駆使して戦場を支配せよ","color":"gold"}
execute as @a[tag=ninja] run title @s subtitle {"text":"変幻自在の忍術で敵を翻弄せよ","color":"dark_purple"}
execute as @a[tag=scout] run title @s subtitle {"text":"ワイヤーを操り、戦場を縦横無尽に駆け巡れ","color":"aqua"}
execute as @a[tag=tank] run title @s subtitle {"text":"歩く要塞となり、戦場を蹂躙せよ","color":"dark_green"}
execute as @a[tag=berserker] run title @s subtitle {"text":"血を捧げ、敵を粉砕せよ","color":"red"}
execute as @a[tag=stalker] run title @s subtitle {"text":"執念深く獲物を追い詰め、息の根を止めよ","color":"dark_red"}
execute as @a[tag=admiral] run title @s subtitle {"text":"暁の水平線に、勝利を刻め！","color":"dark_aqua"}
execute as @a[tag=magician] run title @s subtitle {"text":"魔力を操り、空を舞え","color":"light_purple"}
execute as @a[tag=chrono] run title @s subtitle {"text":"時を操り、戦場の運命を改変せよ","color":"yellow"}
execute as @a[tag=sculptor] run title @s subtitle {"text":"生命を吹き込み、戦場を創造せよ","color":"blue"}
execute as @a[tag=gambler] run title @s subtitle {"text":"運命を賭け、全てを手に入れろ","color":"green"}

# 音とログ
# 【修正】音量を10000にして距離減衰を無視させる（グローバル音化）
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 10000 1
tellraw @a [{"text":"[System] ","color":"gray"},{"text":"試合開始！","color":"green"}]

# --- 3. アイテム配布 (ここで一斉に武装) ---
execute as @a[tag=mechanic] run function my_pvp:system/give_mechanic_items
execute as @a[tag=ninja] run function my_pvp:system/give_ninja_items
execute as @a[tag=scout] run function my_pvp:system/give_scout_items
execute as @a[tag=tank] run function my_pvp:system/give_tank_items
execute as @a[tag=berserker] run function my_pvp:system/give_berserker_items
execute as @a[tag=magician] run function my_pvp:system/give_magician_items
execute as @a[tag=stalker] run function my_pvp:system/give_stalker_items
execute as @a[tag=admiral] run function my_pvp:system/give_admiral_items
execute as @a[tag=chrono] run function my_pvp:system/give_chrono_items
execute as @a[tag=sculptor] run function my_pvp:system/give_sculptor_items
execute as @a[tag=gambler] run function my_pvp:system/give_gambler_items