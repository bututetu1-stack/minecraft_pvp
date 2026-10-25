# 1. 実行者のIDを一時スコアに保存
scoreboard players operation #ID temp = @s player_id

# 2. 自分のIDを持つマーカー全てに一時タグ(my_marker)を付与
tag @e[tag=chrono_marker] remove my_marker
execute as @e[type=area_effect_cloud,tag=chrono_marker] if score @s player_id = #ID temp run tag @s add my_marker

# --- マーカーの更新処理 (自分のマーカーのみ操作) ---

# 3. 寿命が来た(5秒経過した)マーカーを削除
kill @e[tag=my_marker,tag=chrono_5s]

# 4. 時間タグのシフト (4s -> 5s, 3s -> 4s ...)
tag @e[tag=my_marker,tag=chrono_4s] add chrono_5s
tag @e[tag=my_marker,tag=chrono_5s] remove chrono_4s

tag @e[tag=my_marker,tag=chrono_3s] add chrono_4s
tag @e[tag=my_marker,tag=chrono_4s] remove chrono_3s

tag @e[tag=my_marker,tag=chrono_2s] add chrono_3s
tag @e[tag=my_marker,tag=chrono_3s] remove chrono_2s

tag @e[tag=my_marker,tag=chrono_1s] add chrono_2s
tag @e[tag=my_marker,tag=chrono_2s] remove chrono_1s

# 5. 現在地に新しい「1秒前マーカー」を設置
# summonだけだと向きが南(0,0)固定になってしまう
summon area_effect_cloud ~ ~ ~ {Tags:["chrono_marker","chrono_1s"],Duration:200}

# 6. 新規マーカーの設定 (ID付与 & 向きの同期 & HP記録 & CTスナップショット)
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s player_id = #ID temp

# 【修正】 chronoプレイヤー(=@s, 呼び出し元)の生HPをNBTから取得 (health objective は HP×10 のため使えない)
execute store result score #PLAYER_HP temp run data get entity @s Health
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s hp_snapshot = #PLAYER_HP temp

# 【追加】 CTスナップショット (5秒前のCT状態を保存) - リバース時にCT巻き戻しで使用
scoreboard players operation #SS_STASIS temp = @s cd_chrono_stasis
scoreboard players operation #SS_CLOCKUP temp = @s cd_chrono_clockup
scoreboard players operation #SS_JUMP temp = @s cd_chrono_jump
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s cd_chrono_stasis = #SS_STASIS temp
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s cd_chrono_clockup = #SS_CLOCKUP temp
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s cd_chrono_jump = #SS_JUMP temp

# 【重要】実行コンテキスト(プレイヤーの場所・向き)に合わせてマーカーの向きを回転させる
# ~ ~ ~ ~ ~ は「位置を変えずに、向きだけ現在の実行環境に合わせる」という意味
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run tp @s ~ ~ ~ ~ ~

# 7. 掃除
tag @e[tag=my_marker] remove my_marker