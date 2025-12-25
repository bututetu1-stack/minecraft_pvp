# 1. アイテム設定
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if entity @p[tag=ninja,distance=..300] run tag @s add can_process

# 2. 所有者をIDで特定 (誤爆防止の肝)
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_user
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_user

# --- 分岐A: CT中 (返却して終了) ---
# CT判定: 所有者(current_user)のスコアを見る
execute if entity @s[tag=can_process] as @p[tag=current_user,scores={cd_ninja_smoke=1..}] run give @s minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# 落ちているアイテムを消す
execute if entity @s[tag=can_process] as @p[tag=current_user,scores={cd_ninja_smoke=1..}] run kill @e[tag=can_process,limit=1,distance=..1]

# 終了処理
execute as @p[tag=current_user,scores={cd_ninja_smoke=1..}] run return 1


# --- 分岐B: 成功 (発動) ---
# 1. CT設定
execute if entity @s[tag=can_process] as @p[tag=current_user] run scoreboard players set @s cd_ninja_smoke 300

# 2. 発動処理
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 2 2 2 0.05 100
particle minecraft:large_smoke ~ ~0.5 ~ 1 1 1 0.1 50
playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 2 0.5

# 3. 効果付与 (半径4m以内)
# 【修正】アイテムに記録されたID(#TEMP)と一致しないプレイヤーだけを狙う
execute at @s as @a[distance=..4] unless score @s player_id = #TEMP player_id run effect give @s minecraft:blindness 5 0 true
execute at @s as @a[distance=..4] unless score @s player_id = #TEMP player_id run title @s actionbar {"text":"煙に巻かれた！","color":"gray"}

# 4. 後始末
kill @s