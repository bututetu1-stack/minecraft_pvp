# Apply Roulette Effect based on Sector ID (#FINAL_ROT temp)
# @s = Player

# 0 Red (Damage)
execute if score #FINAL_ROT temp matches 0 run tellraw @s {"text":"[Roulette] Red: Damage!","color":"red"}
execute if score #FINAL_ROT temp matches 0 run damage @s 6 minecraft:magic

# 1 Blue (Regen)
execute if score #FINAL_ROT temp matches 1 run tellraw @s {"text":"[Roulette] Blue: Regen!","color":"blue"}
execute if score #FINAL_ROT temp matches 1 run effect give @s minecraft:regeneration 5 1

# 2 Gold (Coin Bonus)
execute if score #FINAL_ROT temp matches 2 run tellraw @s {"text":"[Roulette] Gold: Coins!","color":"gold"}
execute if score #FINAL_ROT temp matches 2 if entity @s[tag=gambler] run scoreboard players add @s coins 50

# 3 Green (Speed)
execute if score #FINAL_ROT temp matches 3 run tellraw @s {"text":"[Roulette] Green: Speed!","color":"green"}
execute if score #FINAL_ROT temp matches 3 run effect give @s minecraft:speed 10 1

# 4 Gray (Slowness)
execute if score #FINAL_ROT temp matches 4 run tellraw @s {"text":"[Roulette] Gray: Slowness!","color":"gray"}
execute if score #FINAL_ROT temp matches 4 run effect give @s minecraft:slowness 5 1

# 5 Purple (Heavy Damage)
execute if score #FINAL_ROT temp matches 5 run tellraw @s {"text":"[Roulette] Purple: Heavy Damage!","color":"dark_purple"}
execute if score #FINAL_ROT temp matches 5 run damage @s 12 minecraft:magic

# 6 Aqua (Heal)
execute if score #FINAL_ROT temp matches 6 run tellraw @s {"text":"[Roulette] Aqua: Heal!","color":"aqua"}
execute if score #FINAL_ROT temp matches 6 run effect give @s minecraft:instant_health 1 0

# 7 White (Jackpot)
execute if score #FINAL_ROT temp matches 7 run tellraw @s {"text":"[Roulette] WHITE: JACKPOT!","color":"white","bold":true}
execute if score #FINAL_ROT temp matches 7 if entity @s[tag=gambler] run scoreboard players add @s coins 100

# 8 Orange (Levitation)
execute if score #FINAL_ROT temp matches 8 run tellraw @s {"text":"[Roulette] Orange: Levitation!","color":"#FFA500"}
execute if score #FINAL_ROT temp matches 8 run effect give @s minecraft:levitation 3 1

# 9 Black (Blindness)
execute if score #FINAL_ROT temp matches 9 run tellraw @s {"text":"[Roulette] Black: Blindness!","color":"black"}
execute if score #FINAL_ROT temp matches 9 run effect give @s minecraft:blindness 5 0

# 10 Pink (Strength)
execute if score #FINAL_ROT temp matches 10 run tellraw @s {"text":"[Roulette] Pink: Strength!","color":"light_purple"}
execute if score #FINAL_ROT temp matches 10 run effect give @s minecraft:strength 10 0

# 11 Light Gray (Weakness)
execute if score #FINAL_ROT temp matches 11 run tellraw @s {"text":"[Roulette] Light Gray: Weakness!","color":"gray"}
execute if score #FINAL_ROT temp matches 11 run effect give @s minecraft:weakness 10 0
