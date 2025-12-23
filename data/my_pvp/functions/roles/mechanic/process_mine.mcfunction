execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:iron_trapdoor{display:{Name:'{"text":"地雷","italic":false,"color":"gray"}'}} 1

# --- 状態チェック ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# A. CD中
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=1..}] run tag @s add on_cd
# B. OK (コスト2)
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=0,scrap=2..}] run tag @s add is_ready
# C. 金欠
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=0,scrap=..1}] run tag @s add no_money

# --- 分岐実行 ---
# 成功（クールダウン 60tick = 3秒）
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s place_cd 60
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_mine

# CDエラー
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error

# 金欠エラー
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

execute if entity @s[tag=can_process] run kill @s