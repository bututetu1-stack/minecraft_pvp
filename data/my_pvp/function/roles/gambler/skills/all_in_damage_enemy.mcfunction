# All-In Damage Macro (Enemy)
# Arguments: $(amount) - Damage calculation from storage

tellraw @s {"text":"[DEBUG] Enemy Macro Amount: $(amount)"}
$damage @s $(amount) minecraft:magic by @p[tag=attacker]
