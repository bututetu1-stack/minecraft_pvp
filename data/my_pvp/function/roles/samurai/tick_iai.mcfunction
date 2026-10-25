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

# --- 突進中の演出 (強化) ---
# 軌跡パーティクル (鈍色 + 白)
particle minecraft:dust{color:[0.6,0.7,0.85],scale:0.9} ~ ~1 ~ 0.4 0.4 0.4 0 8 force
particle minecraft:sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 4 force
particle minecraft:enchanted_hit ~ ~1 ~ 0.2 0.2 0.2 0 3 force
# 足元残光
particle minecraft:end_rod ~ ~0.1 ~ 0.3 0 0.3 0.05 4 force
# 風切り音 (毎tick軽め)
execute at @s run playsound minecraft:item.trident.return master @a ~ ~ ~ 0.4 1.6

# 命中時の追加演出
execute as @a[tag=sam_iai_hit] at @s run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
execute as @a[tag=sam_iai_hit] at @s run particle minecraft:dust{color:[1.0,0.0,0.0],scale:1.2} ~ ~1 ~ 0.5 0.5 0.5 0 20 force
execute as @a[tag=sam_iai_hit] at @s run playsound minecraft:item.trident.hit_ground master @a ~ ~ ~ 1.5 1.5
execute as @a[tag=sam_iai_hit] at @s run playsound minecraft:entity.player.attack.crit master @a ~ ~ ~ 1.5 1.4

# 終了処理
execute if score @s sam_iai_active matches ..0 run tag @s remove sam_iai_dashing
execute if score @s sam_iai_active matches ..0 run tag @a remove sam_iai_hit_this_dash
# 終了時の鞘鳴り音
execute if score @s sam_iai_active matches ..0 at @s run playsound minecraft:item.armor.equip_iron master @a ~ ~ ~ 1 0.7

# 後処理
tag @a remove sam_iai_hit
