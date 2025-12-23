execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:piston{display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}'}} 1

# --- 状態チェック ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# A. CD中
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=1..}] run tag @s add on_cd
# B. OK (コスト3)
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=0,scrap=3..}] run tag @s add is_ready
# C. 金欠
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=0,scrap=..2}] run tag @s add no_money

# --- 分岐実行 ---
# 成功（クールダウン 100tick = 5秒）
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s place_cd 100
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_launcher

# CDエラー
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error

# 金欠エラー
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# 踏みつけ判定
execute if entity @s[tag=can_process] as @e[tag=launcher,limit=1,sort=nearest] at @s if entity @p[tag=mechanic,distance=..1.5] run function my_pvp:roles/mechanic/launcher_trigger

execute if entity @s[tag=can_process] run kill @s