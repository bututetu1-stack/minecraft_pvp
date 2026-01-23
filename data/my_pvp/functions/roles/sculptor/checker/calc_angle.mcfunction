# 角度計算と壁チェック呼び出し
# @s = pattern (player)
# @e[tag=target_hitbox] = target

# 角度計算と壁チェック呼び出し
# @s = pattern (player)
# @e[tag=target_hitbox] = target

# デバッグ: 計算開始
# tellraw @s [{"text":"[DEBUG] Calc Angle Start","color":"aqua"}]

# 1. プレイヤーのYaw取得 (×100)
execute store result score #P_YAW temp run data get entity @s Rotation[0] 100

# 2. ターゲットへの向きを取得 (マーカー使用)
# プレイヤーの位置(@s)で行う
execute at @s run summon marker ~ ~ ~ {Tags:["fov_calc"]}

# マーカーをターゲットに向ける (tpコマンドのfacingを使用)
execute as @e[tag=fov_calc,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=target_hitbox,limit=1] feet

# マーカーのYaw取得
execute store result score #T_YAW temp run data get entity @e[tag=fov_calc,limit=1] Rotation[0] 100
# マーカー削除
kill @e[tag=fov_calc]

# 3. 差分計算
scoreboard players operation #DIFF temp = #P_YAW temp
scoreboard players operation #DIFF temp -= #T_YAW temp

# 4. 正規化 (-18000 ~ 18000 に収める)
# 180度(18000)を超えていたら、360度(36000)引く
execute if score #DIFF temp matches 18001.. run scoreboard players remove #DIFF temp 36000
# -180度(-18000)を下回っていたら、360度(36000)足す
execute if score #DIFF temp matches ..-18001 run scoreboard players add #DIFF temp 36000

# 5. 絶対値
# 定数定義の修正: オブジェクティブは temp を使用
scoreboard players set #CONST_MINUS_1 temp -1
execute if score #DIFF temp matches ..-1 run scoreboard players operation #DIFF temp *= #CONST_MINUS_1 temp

# デバッグ
# tellraw @s [{"text":"[DEBUG] Angle Diff: ","color":"yellow"},{"score":{"name":"#DIFF","objective":"temp"}}]

# 6. FOV判定 (横幅 120度 = ±60度 = 6000)
# 壁チェックへ
execute if score #DIFF temp matches ..6000 run function my_pvp:roles/sculptor/checker/start_wall_check
