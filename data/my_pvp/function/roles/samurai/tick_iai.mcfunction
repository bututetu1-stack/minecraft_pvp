# 居合斬撃中の毎tick処理

# 残り時間消化
scoreboard players remove @s sam_iai_active 1

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 前方へ加速移動 (水平方向に毎tick 1.2マス進む)
# ※ rotated ~ 0: 上下の視線で判定すると、少し下を向いただけで地面を壁と判定して止まっていた
# 前方 1.5マス (足元・頭の高さ) に壁があれば突進終了 (草・花・水などは通過できる)
tag @s remove sam_iai_blocked
execute at @s rotated ~ 0 positioned ^ ^ ^1.5 unless block ~ ~ ~ #my_pvp:dash_passable run tag @s add sam_iai_blocked
execute at @s rotated ~ 0 positioned ^ ^1 ^1.5 unless block ~ ~ ~ #my_pvp:dash_passable run tag @s add sam_iai_blocked
# 壁に当たった場合も、下の終了処理まで進める (以前は return して突進状態が残っていた)
execute if entity @s[tag=sam_iai_blocked] run scoreboard players set @s sam_iai_active 0
execute unless entity @s[tag=sam_iai_blocked] at @s rotated ~ 0 run tp @s ^ ^ ^1.2
tag @s remove sam_iai_blocked

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
