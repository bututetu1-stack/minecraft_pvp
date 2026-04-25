# Advancementの解除
advancement revoke @s only my_pvp:roles/admiral_hurt

# 無限ループ防止 (不要になったため削除)
# execute if entity @s[tag=processing_penalty] run return 0
# tag @s add processing_penalty

# 1. アタッカーの特定
# このtickで「与ダメージ(damage_dealt)」が増えたプレイヤーを探す
tag @a remove current_attacker
execute as @a[distance=..64] unless score @s damage_dealt = @s last_damage_dealt run tag @s add current_attacker

# 2. ダメージ量の計算 (元のダメージの 25%)
scoreboard players operation #CALC temp = @s damage_taken

# 25%計算 (DamageScore / 40 -> DamageAmount / 4)
scoreboard players operation #CALC temp /= #CONST_40 temp

# 3. ダメージ実行予約 (Delay to bypass i-frames)

# Store Damage & Set Timer
execute if score #CALC temp matches 1.. run scoreboard players operation @s penalty_dmg = #CALC temp
execute if score #CALC temp matches 1.. run scoreboard players set @s penalty_timer 12
execute if score #CALC temp matches 1.. run tag @s add adm_penalty_target

# Force Brute Force Application (Reliable) -> MOVED TO DELAYED FUNCTION
# execute if score #CALC temp matches 1.. run function my_pvp:roles/admiral/apply_penalty_brute

# 4. 後処理
# tag @s remove processing_penalty は admrial_main で行う
