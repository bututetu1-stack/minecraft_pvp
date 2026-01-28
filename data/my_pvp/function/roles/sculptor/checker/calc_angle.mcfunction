# 角度計算
# @s = プレイヤー

# 1. プレイヤーのYaw取得 (x100)
execute store result score #P_YAW temp run data get entity @s Rotation[0] 100

# 2. マーカーでターゲット方向を取得
execute at @s run summon marker ~ ~ ~ {Tags:["fov_calc"]}
execute as @e[tag=fov_calc,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=target_hitbox,limit=1] feet
execute store result score #T_YAW temp run data get entity @e[tag=fov_calc,limit=1] Rotation[0] 100
kill @e[tag=fov_calc]

# 3. 差分計算
scoreboard players operation #DIFF temp = #P_YAW temp
scoreboard players operation #DIFF temp -= #T_YAW temp

# 4. 正規化 (-18000 ~ 18000)
execute if score #DIFF temp matches 18001.. run scoreboard players remove #DIFF temp 36000
execute if score #DIFF temp matches ..-18001 run scoreboard players add #DIFF temp 36000

# 5. 絶対値
scoreboard players set #NEG temp -1
execute if score #DIFF temp matches ..-1 run scoreboard players operation #DIFF temp *= #NEG temp

# 6. FOV判定 (60度 = 6000) -> 壁チェックへ
execute if score #DIFF temp matches ..6000 run function my_pvp:roles/sculptor/checker/start_wall_check
