# 狼 毎tick処理 (@s = wolf entity, at @s)
# 通常 vanilla 物理は NoAI:1b で停止しているため、重力 / 衝突 / 段差登りを手動実装

# 1. ターゲット選定 (自分以外のプレイヤー、半径20)
scoreboard players operation #WOLF_OWNER temp = @s player_id
tag @a remove wolf_target_candidate
execute at @s as @a[gamemode=!spectator,distance=..20] unless score @s player_id = #WOLF_OWNER temp run tag @s add wolf_target_candidate
tag @a remove wolf_my_target
execute at @s as @a[tag=wolf_target_candidate,sort=nearest,limit=1] run tag @s add wolf_my_target

# ターゲット無し → 軽く見回し演出
execute unless entity @a[tag=wolf_my_target] at @s run particle minecraft:dust{color:[0.5,0.5,0.5],scale:0.4} ~ ~1 ~ 0.2 0.2 0.2 0 1 force

# === 移動 (ターゲット有り時のみ) ===
# ターゲット方向に向く (水平のみ)
execute if entity @a[tag=wolf_my_target] at @s run tp @s ~ ~ ~ facing entity @a[tag=wolf_my_target,limit=1] feet
execute if entity @a[tag=wolf_my_target] at @s run tp @s ~ ~ ~ ~ 0

# 移動試行
tag @s remove wolf_can_move
tag @s remove wolf_step_up

# 通常移動: 前方0.25m先で足元と頭部が空気
execute if entity @a[tag=wolf_my_target] at @s positioned ^ ^ ^0.25 if block ~ ~ ~ #my_pvp:transparent if block ~ ~1 ~ #my_pvp:transparent run tag @s add wolf_can_move

# 階段登り: 前方足元はブロック、+1m と +2m が空気 (1ブロック段差)
execute if entity @a[tag=wolf_my_target,tag=!wolf_can_move] at @s positioned ^ ^ ^0.25 unless block ~ ~ ~ #my_pvp:transparent if block ~ ~1 ~ #my_pvp:transparent if block ~ ~2 ~ #my_pvp:transparent run tag @s add wolf_step_up

# 適用
execute if entity @s[tag=wolf_can_move] run tp @s ^ ^ ^0.25
execute if entity @s[tag=wolf_step_up] run tp @s ^ ^1 ^0.25

# どちらもNG (壁ぶつかり) → 移動しない (足踏み演出のみ)
execute if entity @a[tag=wolf_my_target] if entity @s[tag=!wolf_can_move,tag=!wolf_step_up] at @s run particle minecraft:dust{color:[0.7,0.4,0.2],scale:0.5} ~ ~0.5 ~ 0.2 0.1 0.2 0 2 force

tag @s remove wolf_can_move
tag @s remove wolf_step_up

# === 重力 (移動後に適用、層別の落下速度で確実に落とす) ===
# A. 足元-2まで全部透明 (2m以上の落下) → 1.0m 急降下
execute at @s if block ~ ~-0.5 ~ #my_pvp:transparent if block ~ ~-1.5 ~ #my_pvp:transparent run tp @s ~ ~-1.0 ~
# B. 足元-1まで透明、足元-2は固体 (1m落下で着地) → 0.5m 落下 (次tickで完全着地)
execute at @s if block ~ ~-0.5 ~ #my_pvp:transparent unless block ~ ~-1.5 ~ #my_pvp:transparent run tp @s ~ ~-0.5 ~

# === 攻撃 (毎20tick = 1秒、距離1.8以内) ===
scoreboard players add @s wolf_attack_timer 1
execute if score @s wolf_attack_timer matches 20.. at @s if entity @a[tag=wolf_my_target,distance=..1.8] as @a[tag=wolf_my_target,distance=..1.8,limit=1] run damage @s 2 minecraft:magic
execute if score @s wolf_attack_timer matches 20.. at @s if entity @a[tag=wolf_my_target,distance=..1.8] run playsound minecraft:entity.wolf.hurt master @a ~ ~ ~ 1 1.3
execute if score @s wolf_attack_timer matches 20.. at @s if entity @a[tag=wolf_my_target,distance=..1.8] run particle minecraft:crit ~ ~1 ~ 0.3 0.3 0.3 0.2 8 force
execute if score @s wolf_attack_timer matches 20.. run scoreboard players set @s wolf_attack_timer 0

# === 視覚演出 (常時) ===
execute at @s run particle minecraft:dust{color:[0.5,0.5,0.5],scale:0.5} ~ ~0.5 ~ 0.1 0.1 0.1 0 1 force

# 後始末
tag @a remove wolf_target_candidate
tag @a remove wolf_my_target
