# Advancementの解除
advancement revoke @s only my_pvp:roles/admiral_hurt

# 無限ループ防止 (不要になったため削除)
# execute if entity @s[tag=processing_penalty] run return 0
# tag @s add processing_penalty

# 1. アタッカーの特定
# 直前に攻撃してきたプレイヤーの ID を保存 (いなければ 0)。ダメージは 12tick 後なのでタグではなく ID で持つ
# ※ 以前の damage_dealt と last_damage_dealt の比較は、last_damage_dealt を更新する役職が限られるため
#    64m以内のほぼ全員 (提督自身を含む) が攻撃者扱いになっていた
scoreboard players set #ADM_ATTACKER temp 0
execute on attacker if entity @s[type=player] run scoreboard players operation #ADM_ATTACKER temp = @s player_id

# 2. ダメージ量の計算 (元のダメージの 50%, 合計1.5倍化)
scoreboard players operation #CALC temp = @s damage_taken

# 50%計算 (DamageScore / 20 -> DamageAmount / 2)
scoreboard players set #CONST_20 temp 20
scoreboard players operation #CALC temp /= #CONST_20 temp

# 3. ダメージ実行予約 (Delay to bypass i-frames)

# Store Damage & Set Timer
execute if score #CALC temp matches 1.. run scoreboard players operation @s penalty_dmg = #CALC temp
execute if score #CALC temp matches 1.. run scoreboard players set @s penalty_timer 12
execute if score #CALC temp matches 1.. run tag @s add adm_penalty_target
execute if score #CALC temp matches 1.. run scoreboard players operation @s penalty_attacker = #ADM_ATTACKER temp

# Force Brute Force Application (Reliable) -> MOVED TO DELAYED FUNCTION
# execute if score #CALC temp matches 1.. run function my_pvp:roles/admiral/apply_penalty_brute

# 4. 後処理
# tag @s remove processing_penalty は admrial_main で行う
