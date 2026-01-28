# ルーレットイベント開始
# 重複防止のためクリーンアップ
function my_pvp:events/roulette/cleanup

title @a title [{"text":"【運命のルーレット】","color":"gold","bold":true}]
title @a subtitle [{"text":"巨大ルーレットが出現！","color":"yellow"}]
tellraw @a [{"text":"[EVENT] ","color":"gold"},{"text":"運命のルーレット","color":"yellow","bold":true},{"text":" - 何が起こるか運次第！","color":"white"}]

# サウンド
execute as @a at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1

# ルーレット中心点の召喚 (game_centerの上空0.5ブロック - 床表示)
execute at @e[tag=game_center,limit=1] run summon marker ~ ~0.5 ~ {Tags:["roulette_center"]}

# 初期速度設定
scoreboard players set @e[tag=roulette_center] roulette_timer 40

# ルーレットの回転時間設定
scoreboard players set #GLOBAL event_duration 200
scoreboard players set #ROULETTE_STATE temp 0

# セクターエンティティの生成
execute as @e[tag=roulette_center] at @s run function my_pvp:events/roulette/init_sectors
