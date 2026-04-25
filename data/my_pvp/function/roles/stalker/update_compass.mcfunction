# ターゲット(@a[tag=my_target])の位置情報を取得し、コンパスを更新する

# 1. ターゲット確認
execute unless entity @a[tag=my_target] run return 0

# 2. ターゲットの座標をStorageに取得 (Double型)
#    必ず at ではなく as でターゲット自身の座標を取得
execute as @a[tag=my_target,limit=1] run data modify storage my_pvp:temp target_pos set from entity @s Pos

# 3. Double -> Int に変換して保存
execute store result storage my_pvp:temp target_x int 1 run data get storage my_pvp:temp target_pos[0]
execute store result storage my_pvp:temp target_y int 1 run data get storage my_pvp:temp target_pos[1]
execute store result storage my_pvp:temp target_z int 1 run data get storage my_pvp:temp target_pos[2]

# 4. 【データ更新】インベントリ内にあるコンパスのデータを書き換える
#    (これをやっておくと、持ち替えたときにも正しい座標が維持されます)
execute run data modify entity @s Inventory[{components:{"minecraft:custom_data":{is_tracking_compass:1b}}}].components."minecraft:lodestone_tracker".target.pos[0] set from storage my_pvp:temp target_x
execute run data modify entity @s Inventory[{components:{"minecraft:custom_data":{is_tracking_compass:1b}}}].components."minecraft:lodestone_tracker".target.pos[1] set from storage my_pvp:temp target_y
execute run data modify entity @s Inventory[{components:{"minecraft:custom_data":{is_tracking_compass:1b}}}].components."minecraft:lodestone_tracker".target.pos[2] set from storage my_pvp:temp target_z

# 5. 【描画更新】手に持っている場合、直接componentsを書き換える
#    (LodestoneTrackerコンポーネントのtargetフィールドを更新)

# メインハンドで持っている場合 (custom_data判定)
execute if data entity @s SelectedItem.components."minecraft:custom_data".is_tracking_compass run data modify entity @s SelectedItem.components."minecraft:lodestone_tracker".target.pos[0] set from storage my_pvp:temp target_x
execute if data entity @s SelectedItem.components."minecraft:custom_data".is_tracking_compass run data modify entity @s SelectedItem.components."minecraft:lodestone_tracker".target.pos[1] set from storage my_pvp:temp target_y
execute if data entity @s SelectedItem.components."minecraft:custom_data".is_tracking_compass run data modify entity @s SelectedItem.components."minecraft:lodestone_tracker".target.pos[2] set from storage my_pvp:temp target_z

# オフハンドで持っている場合
execute if data entity @s Inventory[{Slot:-106b}].components."minecraft:custom_data".is_tracking_compass run data modify entity @s Inventory[{Slot:-106b}].components."minecraft:lodestone_tracker".target.pos[0] set from storage my_pvp:temp target_x
execute if data entity @s Inventory[{Slot:-106b}].components."minecraft:custom_data".is_tracking_compass run data modify entity @s Inventory[{Slot:-106b}].components."minecraft:lodestone_tracker".target.pos[1] set from storage my_pvp:temp target_y
execute if data entity @s Inventory[{Slot:-106b}].components."minecraft:custom_data".is_tracking_compass run data modify entity @s Inventory[{Slot:-106b}].components."minecraft:lodestone_tracker".target.pos[2] set from storage my_pvp:temp target_z

# 6. アクションバー表示 (狩りスタックも併記)
title @s actionbar [{"text":"Target: ","color":"gray"},{"selector":"@a[tag=my_target,limit=1]","color":"red"},{"text":" | 狩 ","color":"dark_red"},{"score":{"name":"@s","objective":"hunting_stacks"},"color":"yellow"},{"text":"/3","color":"dark_red"}]

# 7. ターゲット位置の追跡パーティクル (10tickごと、ストーカーにだけ見える紫粒子)
scoreboard players add @s trail_timer 1
execute if score @s trail_timer matches 10.. at @a[tag=my_target,limit=1] run particle minecraft:dust_color_transition{from_color:[0.4,0.0,0.6],to_color:[1.0,0.0,0.5],scale:1.0} ~ ~1 ~ 0.4 0.5 0.4 0 5 force @s
execute if score @s trail_timer matches 10.. at @a[tag=my_target,limit=1] run particle minecraft:soul_fire_flame ~ ~1 ~ 0.2 0.3 0.2 0 2 force @s
execute if score @s trail_timer matches 10.. run scoreboard players set @s trail_timer 0