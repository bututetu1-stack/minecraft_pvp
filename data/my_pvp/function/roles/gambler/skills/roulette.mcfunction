# 運命のルーレット (Roulette)
# @s = player

execute if score @s coins matches ..-1 run tellraw @s {"text":"[System] 借金中はギャンブルを行えません","color":"red"}
execute if score @s coins matches ..-1 run item replace entity @s hotbar.3 with minecraft:ghast_tear[custom_name='{"text":"運命のルーレット","color":"light_purple","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (25 Coins)","color":"gray"}']]
execute if score @s coins matches ..-1 run return 0

# コイン消費
# コイン消費
execute unless entity @s[tag=rush_mode] run scoreboard players remove @s coins 25
tellraw @s {"text":"[Roulette] ルーレットを回します (3秒後結果)","color":"light_purple"}

# マーカー生成 (タイマー管理用)
# マーカー生成 (タイマー管理用)
summon marker ~ ~ ~ {Tags:["roulette_marker","gambler_roulette_center","new_roulette"]}
execute as @e[tag=new_roulette] run scoreboard players set @s roulette_timer 60
# ランダムな開始角度 (Random Start)
execute store result entity @e[tag=new_roulette,limit=1] Rotation[0] float 1 run random value 0..360
# 盤面生成 (Small Version)
execute as @e[tag=new_roulette] run function my_pvp:roles/gambler/skills/roulette_init
# 所有者IDを紐付け
tag @e[tag=new_roulette] remove new_roulette

# パーティクル演出 (毎tick処理が必要 -> gambler_mainかgame_logicで回す)
# アイテム補充
item replace entity @s hotbar.3 with minecraft:ghast_tear[custom_name='{"text":"運命のルーレット","color":"light_purple","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (25 Coins)","color":"gray"}']]
