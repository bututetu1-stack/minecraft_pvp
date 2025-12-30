# 1. パッシブ: 移動速度上昇
effect give @s minecraft:speed 1 1 true
function my_pvp:roles/ninja/wall_run

# 2. UI表示 (Swap -> Shadow -> Smoke の順に変更)
title @s actionbar [{"text":"Swap: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_ninja_swap"},"color":"white"},{"text":" | Shadow: ","color":"dark_purple"},{"score":{"name":"@s","objective":"cd_ninja_mark"},"color":"white"},{"text":" | Smoke: ","color":"gray"},{"score":{"name":"@s","objective":"cd_ninja_smoke"},"color":"white"}]

# 3. クールダウン消化 & アイテム返却

# 影縫い
execute as @s[scores={cd_ninja_mark=1}] run item replace entity @s container.4 with minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1
execute as @s[scores={cd_ninja_mark=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_ninja_mark=1..}] cd_ninja_mark 1

# 変わり身
execute as @s[scores={cd_ninja_swap=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_ninja_swap=1..}] cd_ninja_swap 1

# 煙玉
execute as @s[scores={cd_ninja_smoke=1}] run item replace entity @s container.5 with minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1
execute as @s[scores={cd_ninja_smoke=1}] run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1
scoreboard players remove @s[scores={cd_ninja_smoke=1..}] cd_ninja_smoke 1


# 4. 変わり身（右クリック）検知
execute if score @s click_skill matches 1.. at @s run function my_pvp:roles/ninja/use_swap
scoreboard players set @s click_skill 0