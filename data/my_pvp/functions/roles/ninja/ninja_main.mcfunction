# 1. パッシブ: 移動速度上昇
effect give @s minecraft:speed 1 1 true

# 2. UI表示
title @s actionbar [{"text":"NINJA STATUS","color":"dark_purple"}]

# 3. クールダウン消化 & 通知音
# CTが1のときだけ音を鳴らす (アイテム配布は行わない)
execute as @s[scores={cd_ninja_mark=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
execute as @s[scores={cd_ninja_swap=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
execute as @s[scores={cd_ninja_smoke=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2

# カウントダウン
scoreboard players remove @s[scores={cd_ninja_mark=1..}] cd_ninja_mark 1
scoreboard players remove @s[scores={cd_ninja_swap=1..}] cd_ninja_swap 1
scoreboard players remove @s[scores={cd_ninja_smoke=1..}] cd_ninja_smoke 1

# 4. 変わり身（右クリック）検知
execute if score @s click_skill matches 1.. at @s run function my_pvp:roles/ninja/use_swap
scoreboard players set @s click_skill 0