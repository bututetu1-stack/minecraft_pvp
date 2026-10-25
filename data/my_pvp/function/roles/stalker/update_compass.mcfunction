# ターゲット(@a[tag=my_target])の位置情報を取得し、コンパスを更新する

# 1. ターゲット確認
execute unless entity @a[tag=my_target] run return 0

# 2. ターゲット座標を取得 (Doubleで取得 → Intに変換)
execute as @a[tag=my_target,limit=1] run data modify storage my_pvp:temp target_pos set from entity @s Pos
execute store result storage my_pvp:stalker_macro x int 1 run data get storage my_pvp:temp target_pos[0]
execute store result storage my_pvp:stalker_macro y int 1 run data get storage my_pvp:temp target_pos[1]
execute store result storage my_pvp:stalker_macro z int 1 run data get storage my_pvp:temp target_pos[2]

# 3. data modify でコンパスのターゲット座標を更新 (アイテム再生成しないため flicker なし、毎tick OK)
function my_pvp:roles/stalker/apply_compass with storage my_pvp:stalker_macro

# 4. アクションバー表示 (狩りスタックも併記)
title @s actionbar [{"text":"Target: ","color":"gray"},{"selector":"@a[tag=my_target,limit=1]","color":"red"},{"text":" | 狩 ","color":"dark_red"},{"score":{"name":"@s","objective":"hunting_stacks"},"color":"yellow"},{"text":"/3","color":"dark_red"}]

# 5. ターゲット位置の追跡パーティクル (10tickごと、ストーカーにだけ見える紫粒子)
scoreboard players add @s trail_timer 1
execute if score @s trail_timer matches 10.. at @a[tag=my_target,limit=1] run particle minecraft:dust_color_transition{from_color:[0.4,0.0,0.6],to_color:[1.0,0.0,0.5],scale:1.0} ~ ~1 ~ 0.4 0.5 0.4 0 5 force @s
execute if score @s trail_timer matches 10.. at @a[tag=my_target,limit=1] run particle minecraft:soul_fire_flame ~ ~1 ~ 0.2 0.3 0.2 0 2 force @s
execute if score @s trail_timer matches 10.. run scoreboard players set @s trail_timer 0
