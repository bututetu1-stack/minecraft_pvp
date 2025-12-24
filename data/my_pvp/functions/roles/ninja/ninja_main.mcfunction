# 1. パッシブ: 移動速度上昇
effect give @s minecraft:speed 1 1 true

# 2. UI表示
title @s actionbar [{"text":"NINJA STATUS","color":"dark_purple"}]

# 3. クールダウン消化
scoreboard players remove @s[scores={cd_ninja_mark=1..}] cd_ninja_mark 1
scoreboard players remove @s[scores={cd_ninja_swap=1..}] cd_ninja_swap 1
scoreboard players remove @s[scores={cd_ninja_smoke=1..}] cd_ninja_smoke 1

# --- アイテム補充 (CT完了時) ---
# 煙玉 (CTが1になったら補充)
execute as @s[scores={cd_ninja_smoke=1}] run give @s minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# CT完了音
execute as @s[scores={cd_ninja_mark=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
execute as @s[scores={cd_ninja_swap=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2
execute as @s[scores={cd_ninja_smoke=1}] run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 2

# スコアリセット
execute unless score @s cd_ninja_mark matches 0.. run scoreboard players set @s cd_ninja_mark 0
execute unless score @s cd_ninja_swap matches 0.. run scoreboard players set @s cd_ninja_swap 0
execute unless score @s cd_ninja_smoke matches 0.. run scoreboard players set @s cd_ninja_smoke 0

# --- 変わり身（右クリック）検知 ---
# 【重要】at @s をつけ、必ず「プレイヤーの足元」で実行させる
execute if score @s click_skill matches 1.. at @s run function my_pvp:roles/ninja/use_swap

# 検知スコアをリセット
scoreboard players set @s click_skill 0