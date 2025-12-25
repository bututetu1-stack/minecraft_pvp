# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 地面に着くまで待機
execute unless entity @s[nbt={OnGround:1b}] run return 0

# 3. 持ち主特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_caster

# --- 【重要】アイテム即時補充 ---
execute as @a[tag=current_caster] run give @s minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# 4. CTチェックと発動
# CT中
execute as @a[tag=current_caster,scores={cd_ninja_smoke=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.5

# CTが0なら発動処理
tag @s add smoke_origin
execute if entity @a[tag=current_caster,scores={cd_ninja_smoke=0}] run tag @s add is_success

# 成功時の処理
execute if entity @s[tag=is_success] as @a[tag=current_caster] run scoreboard players set @s cd_ninja_smoke 300
execute if entity @s[tag=is_success] run particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 2 2 2 0.05 100
execute if entity @s[tag=is_success] run particle minecraft:large_smoke ~ ~0.5 ~ 1 1 1 0.1 50
execute if entity @s[tag=is_success] run playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 2 0.5
execute if entity @s[tag=is_success] as @a[distance=..4] unless score @s player_id = #TEMP player_id run effect give @s minecraft:blindness 5 0 true
execute if entity @s[tag=is_success] as @a[distance=..4] unless score @s player_id = #TEMP player_id run title @s actionbar {"text":"煙に巻かれた！","color":"gray"}

# 5. 後始末
kill @s