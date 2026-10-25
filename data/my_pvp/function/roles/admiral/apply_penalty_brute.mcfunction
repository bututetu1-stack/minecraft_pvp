# Hardcoded Penalty Damage (1-10)
# Args: No args needed, acts on @s (victim) based on #CALC temp score

# 1-10 Damage
# 1-10 Damage
execute if score #CALC temp matches 1 run damage @s 1 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 2 run damage @s 2 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 3 run damage @s 3 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 4 run damage @s 4 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 5 run damage @s 5 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 6 run damage @s 6 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 7 run damage @s 7 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 8 run damage @s 8 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 9 run damage @s 9 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]
execute if score #CALC temp matches 10.. run damage @s 10 minecraft:magic by @p[tag=adm_penalty_attacker,limit=1]

# Fallback for no attacker (Environment/Self)
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 1 run damage @s 1 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 2 run damage @s 2 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 3 run damage @s 3 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 4 run damage @s 4 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 5 run damage @s 5 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 6 run damage @s 6 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 7 run damage @s 7 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 8 run damage @s 8 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 9 run damage @s 9 minecraft:magic
execute unless entity @p[tag=adm_penalty_attacker] if score #CALC temp matches 10.. run damage @s 10 minecraft:magic
