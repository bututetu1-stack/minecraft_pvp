# Macro Debug Test
tellraw @a {"text":"[Debug] Function Started (No Macro)","color":"gray"}
$tellraw @a {"text":"[Debug] Macro Expanded. Amount: $(penalty_amount)","color":"light_purple"}
$execute if entity @p[tag=current_attacker] run damage @s $(penalty_amount) my_pvp:penalty by @p[tag=current_attacker,limit=1]
$execute unless entity @p[tag=current_attacker] run damage @s $(penalty_amount) my_pvp:penalty
