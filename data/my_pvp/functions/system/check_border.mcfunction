## Tick 呼び出し用: トリガーに応じてボーダー適用／解除を呼ぶ
# 新規参加者向けにトリガーを毎tickで有効化（join 後でも使えるように）
scoreboard players enable @a border_distance
scoreboard players enable @a border_remove
function my_pvp:system/apply_border
function my_pvp:system/clear_border
