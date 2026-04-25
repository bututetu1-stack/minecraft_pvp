# 居合斬撃中の毎tick処理

# 残り時間消化
scoreboard players remove @s sam_iai_active 1

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 前方へ加速移動 (視線方向に瞬時に1.5マス進む)
execute at @s positioned ^ ^ ^1.5 unless block ~ ~ ~ #my_pvp:transparent run return 0
execute at @s run tp @s ^ ^ ^1.2

# 範囲内の敵をスラッシュ (半径2.5)
tag @a remove sam_iai_hit
execute at @s as @a[distance=..2.5,gamemode=!spectator,tag=!sam_iai_hit_this_dash] unless score @s player_id = #TEMP player_id run tag @s add sam_iai_hit

# ダメージ (8) + 多段ヒット防止用タグ
execute as @a[tag=sam_iai_hit] run damage @s 8 minecraft:magic by @p[tag=samurai,tag=sam_iai_dashing,distance=..3,limit=1]
execute as @a[tag=sam_iai_hit] run tag @s add sam_iai_hit_this_dash

# 演出
particle minecraft:sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 3

# 終了処理
execute if score @s sam_iai_active matches ..0 run tag @s remove sam_iai_dashing
execute if score @s sam_iai_active matches ..0 run tag @a remove sam_iai_hit_this_dash

# 後処理
tag @a remove sam_iai_hit
