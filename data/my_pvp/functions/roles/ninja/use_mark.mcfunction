# 1. アイテム設定
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if entity @p[tag=ninja,distance=..300] run tag @s add can_process

# 2. 所有者をIDで特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_user
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_user

# --- 分岐A: CT中 (返却) ---
execute if entity @s[tag=can_process] as @p[tag=current_user,scores={cd_ninja_mark=1..}] run give @s minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1
execute if entity @s[tag=can_process] as @p[tag=current_user,scores={cd_ninja_mark=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.5
execute if entity @s[tag=can_process] as @p[tag=current_user,scores={cd_ninja_mark=1..}] run kill @e[tag=can_process,limit=1,distance=..1]
execute as @p[tag=current_user,scores={cd_ninja_mark=1..}] run return 1


# --- 分岐B: 成功 (設置) ---
# 1. アイテムを返す
execute if entity @s[tag=can_process] as @p[tag=current_user] run give @s minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# 2. 発動処理 (マーカー設置)
execute if entity @s[tag=can_process] at @s run summon marker ~ ~ ~ {Tags:["temp_shadow_loc"]}

# その場所で、所有者(current_user)として関数を実行
execute if entity @s[tag=can_process] at @e[tag=temp_shadow_loc,limit=1,sort=nearest] as @p[tag=current_user] run function my_pvp:roles/ninja/place_shadow_logic

# マーカー削除
kill @e[tag=temp_shadow_loc]

# 3. 後始末
kill @s