# Delayed Attack Logic (Stalker)
# Decrement timer
scoreboard players remove @s sk_attack_timer 1

# Trigger when 0
execute if score @s sk_attack_timer matches 0 run function my_pvp:roles/stalker/execute_delayed_attack

# Cleanup (if < 0, just in case)
execute if score @s sk_attack_timer matches ..0 run tag @s remove sk_attack_target
