# BJ敗北ペナルティ: 被ダメージ時に追加ダメージ
# @s = gambler (victim)

# 1. 無限ループ防止 (スコアリセット)
scoreboard players set @s damage_taken 0

# 2. 追加ダメージ処理
# 無敵時間をリセットして確実にダメージを通す (被ダメ増の実装)
data modify entity @s HurtTime set value 0s

# 3ダメージ (1.5ハート) の追加魔法ダメージ
# これにより、実質的に「防御力が下がっている」ような痛さを演出
damage @s 3 minecraft:magic
# tellraw @s {"text":"[!] 防御崩壊 (追加ダメージ)","color":"red"}

# 3. クールダウン設定 (連続ヒットによる瞬殺防止 & ループ防止)
# 10 ticks = 0.5秒 (標準的な無敵時間分待機)
scoreboard players set @s bj_hit_cd 10
