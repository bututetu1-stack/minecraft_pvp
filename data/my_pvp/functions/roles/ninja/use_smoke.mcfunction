# 1. アイテム設定 & 権限チェック
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if entity @p[tag=ninja,distance=..300] run tag @s add can_process

# 所有者を一時的にタグ付け
tag @p[tag=ninja,distance=..300,limit=1,sort=nearest] add temp_owner

# --- 分岐A: CT中 (返却して終了) ---
# 1. アイテムを返す
execute if entity @s[tag=can_process] as @p[tag=temp_owner,scores={cd_ninja_smoke=1..}] run give @s minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# 2. 落ちているアイテムを消す (重要: これがないと増殖します)
# 判定範囲を少し広げて確実に消去
execute if entity @s[tag=can_process] as @p[tag=temp_owner,scores={cd_ninja_smoke=1..}] run kill @e[tag=can_process,limit=1,distance=..2]

# 3. CT中の場合のみ、ここでタグを消して終了
execute as @p[tag=temp_owner,scores={cd_ninja_smoke=1..}] run tag @s remove temp_owner
execute unless entity @s run return 0
execute as @p[tag=!temp_owner] run return 0


# --- 分岐B: 成功 (発動) ---
# 【修正】成功時の「give」を削除しました。これでCT完了時の補充のみになります。
# execute if entity @s[tag=can_process] as @p[tag=temp_owner] run give @s ... 1

# 1. CT設定 (300tick = 15秒)
execute if entity @s[tag=can_process] as @p[tag=temp_owner] run scoreboard players set @s cd_ninja_smoke 300

# 2. 発動処理
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 2 2 2 0.05 100
particle minecraft:large_smoke ~ ~0.5 ~ 1 1 1 0.1 50
playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 2 0.5

# 3. 効果付与 (半径4m以内の敵に盲目)
scoreboard players operation #TEMP player_id = @p[tag=temp_owner] player_id
execute at @s as @a[distance=..4] unless score @s player_id = #TEMP player_id run effect give @s minecraft:blindness 5 0 true
execute at @s as @a[distance=..4] unless score @s player_id = #TEMP player_id run title @s actionbar {"text":"煙に巻かれた！","color":"gray"}

# 4. 後始末
kill @s
tag @p remove temp_owner