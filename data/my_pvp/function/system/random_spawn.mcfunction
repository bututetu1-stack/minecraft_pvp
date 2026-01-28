# ランダムスポーン処理 (共通)
# 呼び出し元 (@s) を game_center 基準でランダムな場所に転送する
# 半径: 200, 最小距離: 30 (中央構造物回避), 高さ制限: 45以下

# 1. ランダム転送実行
# (半径50)
execute at @e[tag=game_center,limit=1] run spreadplayers ~ ~ 10 50 under 45 false @s

# 2. 位置チェックループ開始
scoreboard players set @s retry_count 0
execute at @s run function my_pvp:system/check_spawn
