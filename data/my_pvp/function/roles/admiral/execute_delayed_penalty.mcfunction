# Execute the delayed penalty
# Copy stored damage (penalty_dmg) to calculation score (#CALC temp)
scoreboard players operation #CALC temp = @s penalty_dmg

# 【追加】 陣形再チェック: 12tick の遅延中に警戒陣から外れた場合は発動キャンセル
execute unless score @s adm_formation matches 2 run scoreboard players set @s penalty_dmg 0
execute unless score @s adm_formation matches 2 run tag @s remove adm_penalty_target
execute unless score @s adm_formation matches 2 run return 0

# 攻撃者 (trigger_penalty_v2 で記録した ID) を特定
tag @a remove adm_penalty_attacker
scoreboard players operation #ADM_ATTACKER temp = @s penalty_attacker
execute if score #ADM_ATTACKER temp matches 1.. as @a if score @s player_id = #ADM_ATTACKER temp run tag @s add adm_penalty_attacker

# Call Brute Force Function
function my_pvp:roles/admiral/apply_penalty_brute
tag @a remove adm_penalty_attacker

# Reset Score
scoreboard players set @s penalty_dmg 0
tag @s remove adm_penalty_target
