# 自分のUUID(4つの数字の羅列)を取得して、ターゲット(殴った人)のUUIDと比較
# 1つでも違えば終了
execute store result score #MY_UUID_0 temp run data get entity @s UUID[0]
execute unless score #MY_UUID_0 temp = #TARGET_UUID_0 temp run return 0

execute store result score #MY_UUID_1 temp run data get entity @s UUID[1]
execute unless score #MY_UUID_1 temp = #TARGET_UUID_1 temp run return 0

execute store result score #MY_UUID_2 temp run data get entity @s UUID[2]
execute unless score #MY_UUID_2 temp = #TARGET_UUID_2 temp run return 0

execute store result score #MY_UUID_3 temp run data get entity @s UUID[3]
execute unless score #MY_UUID_3 temp = #TARGET_UUID_3 temp run return 0

# 全て一致したら、あなたこそが殴った本人です
tag @s add current_attacker