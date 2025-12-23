# 1. 試合状態を停止
scoreboard players set #GLOBAL match_state 2

# 2. タイトル表示
title @a title {"text":"GAME SET!","color":"red","bold":true}
title @a subtitle {"text":"お疲れ様でした！","color":"yellow"}

# 3. 効果音
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1

# 4. ガジェット等の片付け（リセット処理を呼び出す）
# すぐ消すと味気ないので、少し遅らせるなどの調整も可能ですが、まずは即リセットでOK
function my_pvp:system/reset_game

# 5. 勝者発表（チャット欄）
# ポイントが一番高い人を表示
tellraw @a [{"text":"-------------------","color":"gray"}]
tellraw @a [{"text":"🏆 WINNER: ","color":"gold"},{"selector":"@p[sort=arbitrary,limit=1,scores={points=-9999..}]"}] 
# ※厳密な1位判定は少し複雑なので、まずは「スコアボードを見てね」形式が一番バグが少ないです