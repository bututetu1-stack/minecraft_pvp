# 1. 発動条件チェック
execute unless predicate my_pvp:is_sneaking run return 0
execute if entity @s[nbt={OnGround:1b}] run return 0

# 2. 壁判定 (前後左右 0.6マス)
tag @s remove touching_wall

# --- 4方向のチェック (腰の高さ Y+0.5 で判定) ---

# 前 (^ ^ ^0.6)
execute unless block ^ ^0.5 ^0.6 minecraft:air unless block ^ ^0.5 ^0.6 minecraft:cave_air unless block ^ ^0.5 ^0.6 minecraft:water unless block ^ ^0.5 ^0.6 minecraft:light run tag @s add touching_wall

# 後 (^ ^ ^-0.6)
execute unless block ^ ^0.5 ^-0.6 minecraft:air unless block ^ ^0.5 ^-0.6 minecraft:cave_air unless block ^ ^0.5 ^-0.6 minecraft:water unless block ^ ^0.5 ^-0.6 minecraft:light run tag @s add touching_wall

# 左 (^0.6 ^ ^)
execute unless block ^0.6 ^0.5 ^ minecraft:air unless block ^0.6 ^0.5 ^ minecraft:cave_air unless block ^0.6 ^0.5 ^ minecraft:water unless block ^0.6 ^0.5 ^ minecraft:light run tag @s add touching_wall

# 右 (^-0.6 ^ ^)
execute unless block ^-0.6 ^0.5 ^ minecraft:air unless block ^-0.6 ^0.5 ^ minecraft:cave_air unless block ^-0.6 ^0.5 ^ minecraft:water unless block ^-0.6 ^0.5 ^ minecraft:light run tag @s add touching_wall


# 3. 壁走り実行
# どこか一方向でも壁に触れていれば発動
execute if entity @s[tag=touching_wall] run effect give @s minecraft:levitation 1 3 true

# 演出
execute if entity @s[tag=touching_wall] run particle minecraft:block minecraft:stone ~ ~0.2 ~ 0.2 0 0.2 0.1 5
execute if entity @s[tag=touching_wall] run playsound minecraft:block.scaffolding.hit master @s ~ ~ ~ 0.5 2.0