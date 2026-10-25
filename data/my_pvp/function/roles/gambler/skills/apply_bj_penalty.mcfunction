# BJ敗北ペナルティ: 被ダメージ時に追加ダメージ
# @s = gambler (victim)

# 1. 無限ループ防止 (スコアリセット)
scoreboard players set @s damage_taken 0

# 2. 追加ダメージ処理
# 被弾直後は無敵時間中なので、通常のダメージは通らない (プレイヤーの HurtTime は data modify できない)
# my_pvp:penalty は #minecraft:bypasses_cooldown (無敵時間無視) と #minecraft:bypasses_armor (防具無視) に入れてある

# 3ダメージ (1.5ハート) の追加ダメージ。直前に攻撃してきたプレイヤーがいればその人の攻撃扱いにする
# これにより、実質的に「防御力が下がっている」ような痛さを演出
tag @a remove bj_penalty_attacker
execute on attacker if entity @s[type=player] run tag @s add bj_penalty_attacker
execute if entity @a[tag=bj_penalty_attacker] run damage @s 3 my_pvp:penalty by @a[tag=bj_penalty_attacker,limit=1]
execute unless entity @a[tag=bj_penalty_attacker] run damage @s 3 my_pvp:penalty
tag @a remove bj_penalty_attacker
# tellraw @s {"text":"[!] 防御崩壊 (追加ダメージ)","color":"red"}

# 3. クールダウン設定 (連続ヒットによる瞬殺防止 & ループ防止)
# 10 ticks = 0.5秒 (標準的な無敵時間分待機)
scoreboard players set @s bj_hit_cd 10
