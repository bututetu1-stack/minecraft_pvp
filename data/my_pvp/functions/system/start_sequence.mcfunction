# 1. 試合開始フラグON
scoreboard players set #GLOBAL match_state 1
scoreboard players set #GLOBAL match_timer 0

# 2. 開始アナウンス
# 全員共通のメインタイトル
title @a title {"text":"GAME START!","color":"red","bold":true}

# 役職ごとのサブタイトル
execute as @a[tag=mechanic] run title @s subtitle {"text":"ガジェットを駆使して戦場を支配せよ","color":"yellow"}
execute as @a[tag=ninja] run title @s subtitle {"text":"神速の移動と変わり身の術","color":"gray"}

# ▼▼▼ 追加: スカウトのサブタイトル ▼▼▼
execute as @a[tag=scout] run title @s subtitle {"text":"ワイヤーを操り、戦場を縦横無尽に駆け巡れ","color":"aqua"}
# ▲▲▲ 追加ここまで ▲▲▲

# 音とログ
# 【修正】実行位置がスポーン地点になるのを防ぐため、各プレイヤーの位置(at @s)で再生させる
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 1 1

tellraw @a [{"text":"[System] ","color":"gray"},{"text":"試合開始！","color":"green"}]

# --- 3. アイテム配布 (ここで一斉に武装) ---
execute as @a[tag=mechanic] run function my_pvp:system/give_mechanic_items
execute as @a[tag=ninja] run function my_pvp:system/give_ninja_items

# ▼▼▼ 追加: スカウトのアイテム配布 ▼▼▼
execute as @a[tag=scout] run function my_pvp:system/give_scout_items
# ▲▲▲ 追加ここまで ▲▲▲