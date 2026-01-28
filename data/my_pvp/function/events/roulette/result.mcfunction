# ルーレット結果判定 (Spatial)

# 1. ルーレットの現在の回転角を取得
execute as @e[tag=roulette_center,limit=1] store result score #ROULETTE_ROT temp run data get entity @s Rotation[0]

# 2. 計測用マーカーを召喚
execute at @e[tag=roulette_center,limit=1] run summon marker ~ ~ ~ {Tags:["angle_measure"]}

# 3. 各プレイヤーについて判定
execute as @a at @s run function my_pvp:events/roulette/check_player

# 4. マーカー削除
kill @e[tag=angle_measure]

# 5. 結果表示フェーズ (停止 2秒 = 40tick)
scoreboard players set #GLOBAL event_duration 40
scoreboard players set #ROULETTE_STATE temp 1

# 6. アナウンス
# title @a title [{"text":"【決定！】","color":"gold","bold":true}]
playsound minecraft:ui.toast.challenge_complete master @a
