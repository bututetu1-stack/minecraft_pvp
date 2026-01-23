# 運命のルーレット (Roulette)
# @s = player

# コインチェック (25枚)
execute if score @s coins matches ..24 run tellraw @s {"text":"[System] コインが足りません (必要: 25)","color":"red"}
execute if score @s coins matches ..24 run item replace entity @s hotbar.3 with minecraft:ghast_tear{display:{Name:'{"text":"運命のルーレット","color":"light_purple","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (25 Coins)","color":"gray"}']}}
execute if score @s coins matches ..24 run return 0

# コイン消費
scoreboard players remove @s coins 25
tellraw @s {"text":"[Roulette] ルーレットを回します (3秒後結果)","color":"light_purple"}

# マーカー生成 (タイマー管理用)
# プレイヤー自身で管理するか、マーカーで管理するか。
# 範囲攻撃なので、発動地点にマーカーを置くべき。
summon marker ~ ~ ~ {Tags:["roulette_marker","new_roulette"]}
execute as @e[tag=new_roulette] run scoreboard players set @s roulette_timer 60
# 所有者IDを紐付け（必要なら）
tag @e[tag=new_roulette] remove new_roulette

# パーティクル演出 (毎tick処理が必要 -> gambler_mainかgame_logicで回す)
# アイテム補充
item replace entity @s hotbar.3 with minecraft:ghast_tear{display:{Name:'{"text":"運命のルーレット","color":"light_purple","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (25 Coins)","color":"gray"}']}}
