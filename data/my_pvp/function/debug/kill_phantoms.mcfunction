# Force Kill Phantoms (Emergency Tool)
# Invulnerableタグを削除し、奈落に落として確実に殺す

tellraw @a {"text":"[System] Phantoms Force Kill...","color":"red"}

# 1. Invulnerable解除
execute as @e[type=phantom] run data modify entity @s Invulnerable set value 0b

# 2. 奈落転送 (確実な消滅)
execute as @e[type=phantom] run tp @s ~ -100 ~

# 3. キルコマンド
kill @e[type=phantom]

tellraw @a {"text":"[System] Completed.","color":"green"}
