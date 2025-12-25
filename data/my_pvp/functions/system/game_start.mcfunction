# 1. 試合リセット処理
function my_pvp:system/reset_game

# 2. プレイヤーID割り振り（ここを修正）
# スコアが「1以上」ではない人（0の人、またはスコア自体がない人）全員にIDを配る
execute as @a unless score @s player_id matches 1.. run function my_pvp:system/assign_new_id

# 3. 役職配布プロセス
function my_pvp:system/init_role_deck
function my_pvp:system/distribute_loop

# 4. 試合開始フラグON
scoreboard players set #GLOBAL match_state 1
scoreboard players set #GLOBAL match_timer 0

# 5. アナウンス
title @a title {"text":"GAME START!","color":"red","bold":true}
playsound minecraft:entity.ender_dragon.growl master @a ~ ~ ~ 1 1