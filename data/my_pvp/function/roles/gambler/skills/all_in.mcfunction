# オール・イン (All-In)
# @s = player

# 1. 借金チェック (マイナスなら使用不可)
execute if score @s coins matches ..-1 run tellraw @s {"text":"[System] 借金中はギャンブルを行えません","color":"red"}
execute if score @s coins matches ..-1 run item replace entity @s hotbar.2 with minecraft:gold_nugget[custom_name='{"text":"オール・イン","color":"yellow","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']]
execute if score @s coins matches ..-1 run return 0

# 2. 最低ベット額チェック (40枚未満は不可)
execute if score @s coins matches ..39 run tellraw @s {"text":"[System] All-Inは40コイン以上から可能です","color":"red"}
execute if score @s coins matches ..39 run item replace entity @s hotbar.2 with minecraft:gold_nugget[custom_name='{"text":"オール・イン","color":"yellow","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']]
execute if score @s coins matches ..39 run return 0

# 3. 全消費 & ダメージ計算 (Coins * 0.5)
scoreboard players operation #dmg temp = @s coins
scoreboard players operation #dmg temp /= #2 temp
scoreboard players set @s coins 0

tellraw @s [{"text":"[All-In] ","color":"dark_red","bold":true},{"text":"全財産を賭けます... (Dmg: ","color":"yellow"},{"score":{"name":"#dmg","objective":"temp"}},{"text":")","color":"yellow"}]

# 4. 50%判定 (ターゲット決定)
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #RND temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players operation #RND temp %= #2 temp

# 5. 結果分岐
# Storageにダメージ量を保存 (Macros用)
execute store result storage my_pvp:macro all_in.amount int 1 run scoreboard players get #dmg temp

# 偶数(0) -> 自分 (Self)
execute if score #RND temp matches 0 run tellraw @s {"text":"[All-In] BAD... 自分にダメージ","color":"red","bold":true}
execute if score #RND temp matches 0 run function my_pvp:roles/gambler/skills/all_in_damage_self with storage my_pvp:macro all_in

# 奇数(!=0) -> 敵 (Enemy)
execute unless score #RND temp matches 0 run tellraw @s {"text":"[All-In] SUCCESS! 敵にダメージ","color":"gold","bold":true}
# 半径10m以内の敵 (一番近い敵にダメージ)
tag @s add attacker
execute unless score #RND temp matches 0 as @e[distance=..10,limit=1,sort=nearest,tag=!attacker] run function my_pvp:roles/gambler/skills/all_in_damage_enemy with storage my_pvp:macro all_in
tag @s remove attacker

# アイテム補充
item replace entity @s hotbar.2 with minecraft:gold_nugget[custom_name='{"text":"オール・イン","color":"yellow","italic":false}',lore=['{"text":"[Q]キーでドロップして開始 (All Coins)","color":"gray"}']]
