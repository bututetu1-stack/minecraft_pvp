# 警戒陣ペナルティ: 攻撃者へのカウンターダメージ
# my_pvp:penalty (bypasses_invulnerability) で i-frame を貫通します
# Args: #CALC temp = ダメージ量, current_attacker タグ = 攻撃者

# ダメージキャップ (10)
execute if score #CALC temp matches 11.. run scoreboard players set #CALC temp 10

# 1-10 Damage (攻撃者に直接ダメージ)
execute if score #CALC temp matches 1 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 1 my_pvp:penalty by @s
execute if score #CALC temp matches 2 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 2 my_pvp:penalty by @s
execute if score #CALC temp matches 3 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 3 my_pvp:penalty by @s
execute if score #CALC temp matches 4 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 4 my_pvp:penalty by @s
execute if score #CALC temp matches 5 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 5 my_pvp:penalty by @s
execute if score #CALC temp matches 6 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 6 my_pvp:penalty by @s
execute if score #CALC temp matches 7 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 7 my_pvp:penalty by @s
execute if score #CALC temp matches 8 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 8 my_pvp:penalty by @s
execute if score #CALC temp matches 9 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 9 my_pvp:penalty by @s
execute if score #CALC temp matches 10 if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 10 my_pvp:penalty by @s

# 演出
execute if score #CALC temp matches 1.. if entity @p[tag=current_attacker] at @p[tag=current_attacker,limit=1] run particle minecraft:crit ~ ~1 ~ 0.3 0.5 0.3 0.2 10
execute if score #CALC temp matches 1.. if entity @p[tag=current_attacker] at @p[tag=current_attacker,limit=1] run playsound minecraft:item.shield.block master @a ~ ~ ~ 1 1.2
