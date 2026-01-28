# Execute the delayed attack (Stalker)

# Apply Damage based on tag (critical or normal)
execute if entity @s[tag=sk_critical] run damage @s 10 minecraft:player_attack by @p[tag=stalker,limit=1,sort=nearest]
execute unless entity @s[tag=sk_critical] run damage @s 4 minecraft:player_attack by @p[tag=stalker,limit=1,sort=nearest]

# Reset
tag @s remove sk_critical
tag @s remove sk_attack_target
