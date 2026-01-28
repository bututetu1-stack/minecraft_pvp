# Delayed Penalty Logic
# Decrement timer
scoreboard players remove @s penalty_timer 1

# Debug Countdown (optional, maybe too spammy? Let's hide it)
# execute if score @s penalty_timer matches 1..5 run tellraw @s {"text":"[Debug] Penalty in...","color":"gray"}

# Trigger when 0
execute if score @s penalty_timer matches 0 run function my_pvp:roles/admiral/execute_delayed_penalty

# Cleanup (if < 0, just in case)
execute if score @s penalty_timer matches ..0 run tag @s remove adm_penalty_target
