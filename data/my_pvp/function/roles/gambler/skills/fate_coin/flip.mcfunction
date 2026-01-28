# Fate Coin Flip (Double Up)
# @s = player

# 1. 50%判定
summon marker ~ ~ ~ {Tags:["random_seed"]}
execute store result score #RND temp run data get entity @e[tag=random_seed,limit=1] UUID[0]
kill @e[tag=random_seed]
scoreboard players set #2 temp 2
scoreboard players operation #RND temp %= #2 temp

# 2. 表 (Success - Double Up)
# 次のPot額を計算 (表示用)
execute unless score #RND temp matches 0 run scoreboard players operation #POT_NEXT temp = @s fate_pot
execute unless score #RND temp matches 0 run scoreboard players operation #POT_NEXT temp += @s fate_pot

# 結果表示
execute unless score #RND temp matches 0 run tellraw @s [{"text":"[Fate] ","color":"aqua"},{"text":"WIN! ","color":"gold","bold":true},{"text":"Pot: ","color":"yellow"},{"score":{"name":"@s","objective":"fate_pot"},"color":"gold"},{"text":" -> ","color":"gray"},{"score":{"name":"#POT_NEXT","objective":"temp"},"color":"white","bold":true}]

# 実際に倍増
execute unless score #RND temp matches 0 run scoreboard players operation @s fate_pot = #POT_NEXT temp

# 継続案内
execute unless score #RND temp matches 0 run tellraw @s {"text":"操作: スロット4(銅)ドロップで[Double Up], 3秒放置で[Collect]","color":"green"}
execute unless score #RND temp matches 0 run scoreboard players set @s fate_timer 0
execute unless score #RND temp matches 0 run item replace entity @s hotbar.4 with minecraft:copper_ingot[custom_name='{"text":"運命のコイン","color":"aqua","italic":false}',lore=['{"text":"[Q]キーでドロップして開始/継続","color":"gray"}']]

# 3. 裏 (Fail - Lost All)
execute if score #RND temp matches 0 run tellraw @s {"text":"[Fate] LOSE... (全没収)","color":"red","bold":true}
execute if score #RND temp matches 0 run function my_pvp:roles/gambler/skills/fate_coin/lose
