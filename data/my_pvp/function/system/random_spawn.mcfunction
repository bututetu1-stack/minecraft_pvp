# ランダムスポーン処理 (共通)
# 呼び出し元 (@s) を game_center 基準でランダムな場所に転送する
# 半径50, 内側10は除外 (中央構造物回避)

# 1. ランダム転送実行
execute at @e[tag=game_center,limit=1] run spreadplayers ~ ~ 10 50 under 45 false @s

# 2. スポーン位置チェック (天井 + 地面 + 落下防止)
scoreboard players set @s retry_count 0
execute at @s run function my_pvp:system/check_spawn

# 3. スポーン直後の保護期間 (40tick = 2秒)
# この間に死亡した場合はシステム起因の死としてペナルティを免除する
tag @s add spawn_grace
scoreboard players set @s spawn_grace_timer 40
