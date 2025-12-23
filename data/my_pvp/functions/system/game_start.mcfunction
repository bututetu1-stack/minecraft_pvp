# 1. 試合リセット処理（盤面をきれいにする）
function my_pvp:system/reset_game

# 2. プレイヤーID割り振り（初参加の人用）
execute as @a[scores={player_id=0}] run scoreboard players operation @s player_id = #NEXT_ID player_id
scoreboard players add #NEXT_ID player_id 1

# 3. 役職ガチャ（山札を作って引く）
function my_pvp:system/assign_roles

# 4. 試合開始フラグON
scoreboard players set #GLOBAL match_state 1
scoreboard players set #GLOBAL match_timer 0

# 5. アナウンス
title @a title {"text":"PVP START!","color":"red","bold":true}
playsound minecraft:entity.ender_dragon.growl master @a ~ ~ ~ 1 1