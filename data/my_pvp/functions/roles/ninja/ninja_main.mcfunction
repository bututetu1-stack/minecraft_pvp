# 1. パッシブ: 移動速度上昇
effect give @s minecraft:speed 1 1 true
function my_pvp:roles/ninja/wall_run

# 2. UI表示
title @s actionbar [{"text":"NINJA STATUS","color":"dark_purple"}]

# 3. クールダウン消化 & 通知音 & 【追加】アイテム返却

# 影縫い (変更なし)
execute as @s[scores={cd_ninja_mark=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_ninja_mark=1..}] cd_ninja_mark 1

# 変わり身 (変更なし)
execute as @s[scores={cd_ninja_swap=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_ninja_swap=1..}] cd_ninja_swap 1

# 煙玉 (CT明けに返却)
# カウントが 1 (終了直前) になったらアイテムを配布
execute as @s[scores={cd_ninja_smoke=1}] run give @s minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1
# 通知音
execute as @s[scores={cd_ninja_smoke=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
# カウントダウン
scoreboard players remove @s[scores={cd_ninja_smoke=1..}] cd_ninja_smoke 1


# 4. 変わり身（右クリック）検知
execute if score @s click_skill matches 1.. at @s run function my_pvp:roles/ninja/use_swap
scoreboard players set @s click_skill 0