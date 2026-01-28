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

# 6. 新規マーカーの設定 (ID付与 & 向きの同期 & HP記録)
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s player_id = #ID temp
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run scoreboard players operation @s hp_snapshot = @p[tag=chrono_user,limit=1,distance=..0.1] health
# ※ @s(marker) から @p(player) のスコアを取るため、呼び出し元で @s=player であることを利用するか、距離で特定する
# ここでは呼び出し元がプレイヤー(@s)なので、単純に operation @marker hp = @s health としたいが、
# execute as marker run ... なので @s は marker になる。
# よって、呼び出し元のプレイヤーを参照するために事前にタグをつけるか、operationを工夫する

# 修正案: マーカーに対して operation @s hp_snapshot = #ID temp (間違い) -> @p health
# 呼び出し元で自分にタグがついていると楽。

# 【重要】実行コンテキスト(プレイヤーの場所・向き)に合わせてマーカーの向きを回転させる
# ~ ~ ~ ~ ~ は「位置を変えずに、向きだけ現在の実行環境に合わせる」という意味
execute as @e[type=area_effect_cloud,tag=chrono_1s,distance=..0.1,limit=1,sort=nearest] run tp @s ~ ~ ~ ~ ~

# 7. 掃除
tag @e[tag=my_marker] remove my_marker