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

# 4. 【描画更新】手に持っているコンパスの lodestone_tracker を書き換える
#    プレイヤーのインベントリは data modify できないため、item modify (マクロ) で更新する
#    コンパスは手に持った時だけ意味があるので、メイン/オフハンドのみ更新すれば十分
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{is_tracking_compass:1b}] run function my_pvp:roles/stalker/set_compass_target with storage my_pvp:temp
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{is_tracking_compass:1b}] if items entity @s weapon.offhand *[minecraft:custom_data~{is_tracking_compass:1b}] run function my_pvp:roles/stalker/set_compass_target with storage my_pvp:temp

# 5. アクションバー表示
title @s actionbar [{"text":"Target: ","color":"gray"},{"selector":"@a[tag=my_target,limit=1]","color":"red"}]