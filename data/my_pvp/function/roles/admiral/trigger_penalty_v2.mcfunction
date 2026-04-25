# 【リファクタリング版】 警戒陣の反撃ダメージ
# my_pvp:penalty (bypasses_invulnerability) を使うことで遅延処理が不要になりました。
# 即時ダメージで攻撃者にカウンターを返します。

# Advancementの解除
advancement revoke @s only my_pvp:roles/admiral_hurt

# 1. アタッカーの特定
# このtickで「与ダメージ(damage_dealt)」が増えたプレイヤーを探す
tag @a remove current_attacker
execute as @a[distance=..64] unless score @s damage_dealt = @s last_damage_dealt run tag @s add current_attacker

# 2. ダメージ量の計算 (元のダメージの 25%)
scoreboard players operation #CALC temp = @s damage_taken
scoreboard players operation #CALC temp /= #CONST_40 temp

# 3. 即時カウンター適用 (i-frame貫通)
execute if score #CALC temp matches 1.. if entity @p[tag=current_attacker] run function my_pvp:roles/admiral/apply_penalty_brute

# 後始末
tag @a remove current_attacker
