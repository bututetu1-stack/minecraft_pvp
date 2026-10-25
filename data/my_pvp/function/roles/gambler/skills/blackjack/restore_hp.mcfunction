# BJ敗北デバフの終了処理 (HP上限を戻す + 被ダメージ増加の解除)
# @s = player (called from gambler_main via bj_debuff_timer)
# ※ functions -> function へのフォルダ移行時に消えていたファイルを復元

attribute @s minecraft:max_health base set 40.0
tag @s remove ignore_status_check
tag @s remove bj_debuff
tellraw @s {"text":"[BJ] 防御態勢が戻った","color":"gray"}
