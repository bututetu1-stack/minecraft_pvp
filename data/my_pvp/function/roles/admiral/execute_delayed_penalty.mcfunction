# Execute the delayed penalty
# Copy stored damage (penalty_dmg) to calculation score (#CALC temp)
scoreboard players operation #CALC temp = @s penalty_dmg

# Debug

# Call Brute Force Function
function my_pvp:roles/admiral/apply_penalty_brute

# Reset Score
scoreboard players set @s penalty_dmg 0
tag @s remove adm_penalty_target
