# 彫刻の毎tick処理
# @s = sculpture (armor_stand)

# 所有者のIDを取得
scoreboard players operation #TEMP_OWNER temp = @s player_id

# Hitboxの位置同期 (ズレ防止)
# 自分のスロットIDを持つHitboxを自分にTPさせる
scoreboard players operation #TEMP_SLOT temp = @s sculpture_slot
execute as @e[tag=sculpture_hitbox,limit=1,distance=..5] if score @s player_id = #TEMP_OWNER temp if score @s sculpture_slot = #TEMP_SLOT temp run tp @s ~ ~ ~

# --- パーティクル演出 (20tickごと) ---
execute if score #GLOBAL match_timer matches 1.. store result score #TICK_CHECK temp run scoreboard players get #GLOBAL match_timer
scoreboard players operation #TICK_CHECK temp %= #20 temp

execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_nausea] at @s run particle minecraft:witch ~ ~1.5 ~ 0.2 0.2 0.2 0.02 2
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_poison] at @s run particle minecraft:item_slime ~ ~1.5 ~ 0.2 0.2 0.2 0.02 3
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_slow] at @s run particle minecraft:falling_dust minecraft:cobweb ~ ~1.5 ~ 0.2 0.2 0.2 0.02 2
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_blind] at @s run particle minecraft:smoke ~ ~1.5 ~ 0.2 0.2 0.2 0.02 3
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_glow] at @s run particle minecraft:glow ~ ~1.5 ~ 0.2 0.2 0.2 0.02 3
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_darkness] at @s run particle minecraft:squid_ink ~ ~1.5 ~ 0.2 0.2 0.2 0.02 2
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_fatigue] at @s run particle minecraft:dust 0.3 0.3 0.6 1 ~ ~1.5 ~ 0.2 0.2 0.2 0.02 3
execute if score #TICK_CHECK temp matches 0 as @s[tag=sculpture_heal] at @s run particle minecraft:heart ~ ~1.5 ~ 0.2 0.2 0.2 0.02 2
