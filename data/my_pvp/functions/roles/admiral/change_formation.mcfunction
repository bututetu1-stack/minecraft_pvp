# クールダウンチェック (5秒)
execute if score @s cd_formation matches 1.. run return 0
scoreboard players set @s cd_formation 100

# 1. 陣形カウンターを進める (0 -> 1 -> 2 -> 0...)
scoreboard players add @s adm_formation 1
execute if score @s adm_formation matches 3.. run scoreboard players set @s adm_formation 0

# 2. 陣形ごとのメッセージ(tellraw)とサウンド

# === 0: 単縦陣 (Attack) ===
execute if score @s adm_formation matches 0 run tellraw @s {"text":"[陣形] 単縦陣 (攻撃特化 - 威力100%)","color":"red","bold":true}
execute if score @s adm_formation matches 0 run playsound minecraft:block.anvil.place master @s ~ ~ ~ 0.5 2

# === 1: 輪形陣 (Defense) ===
execute if score @s adm_formation matches 1 run tellraw @s {"text":"[陣形] 輪形陣 (防御特化 - 威力66%)","color":"green","bold":true}
execute if score @s adm_formation matches 1 run playsound minecraft:item.shield.block master @s ~ ~ ~ 1 1

# === 2: 警戒陣 (Speed) ===
execute if score @s adm_formation matches 2 run tellraw @s {"text":"[陣形] 警戒陣 (回避特化 - 威力50%)","color":"aqua","bold":true}
execute if score @s adm_formation matches 2 run playsound minecraft:entity.player.swim master @s ~ ~ ~ 1 2