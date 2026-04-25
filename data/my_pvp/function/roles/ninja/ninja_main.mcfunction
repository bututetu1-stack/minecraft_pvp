# 1. パッシブ: 移動速度上昇
effect give @s minecraft:speed 1 1 true
function my_pvp:roles/ninja/wall_run

# 2. UI表示 (Swap -> Shadow -> Smoke の順に変更)
title @s actionbar [{"text":"Swap: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_ninja_swap"},"color":"white"},{"text":" | Shadow: ","color":"dark_purple"},{"score":{"name":"@s","objective":"cd_ninja_mark"},"color":"white"},{"text":" | Smoke: ","color":"gray"},{"score":{"name":"@s","objective":"cd_ninja_smoke"},"color":"white"}]

# 3. クールダウン消化 & アイテム返却

# 影縫い
execute as @s[scores={cd_ninja_mark=1}] run item replace entity @s container.4 with minecraft:black_dye[custom_name='{"text":"影縫い (設置)","color":"dark_purple"}',lore=['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']] 1
execute as @s[scores={cd_ninja_mark=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_ninja_mark=1..}] cd_ninja_mark 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_ninja_mark=0}] unless entity @s[nbt={Inventory:[{Slot:4b,id:"minecraft:black_dye"}]}] run item replace entity @s container.4 with minecraft:black_dye[custom_name='{"text":"影縫い (設置)","color":"dark_purple"}',lore=['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']] 1

# 変わり身
execute as @s[scores={cd_ninja_swap=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_ninja_swap=1..}] cd_ninja_swap 1

# 煙玉
execute as @s[scores={cd_ninja_smoke=1}] run item replace entity @s container.5 with minecraft:charcoal[custom_name='{"text":"煙玉 (目眩まし)","color":"gray"}',lore=['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']] 1
execute as @s[scores={cd_ninja_smoke=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_ninja_smoke=1..}] cd_ninja_smoke 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_ninja_smoke=0}] unless entity @s[nbt={Inventory:[{Slot:5b,id:"minecraft:charcoal"}]}] run item replace entity @s container.5 with minecraft:charcoal[custom_name='{"text":"煙玉 (目眩まし)","color":"gray"}',lore=['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']] 1


# 4. 変わり身（右クリック）検知
execute if score @s click_skill matches 1.. at @s run function my_pvp:roles/ninja/use_swap
scoreboard players set @s click_skill 0

# 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump