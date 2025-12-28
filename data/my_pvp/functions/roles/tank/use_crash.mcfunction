# 0. 接地チェック
execute unless entity @s[nbt={OnGround:1b}] run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"⚠ 地面でのみ発動可能です","color":"red"}]
execute unless entity @s[nbt={OnGround:1b}] run return 0

# 1. CTチェック
execute if score @s cd_tank_crash matches 1.. run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"スキル準備中... (Cooldown)","color":"red"}]
execute if score @s cd_tank_crash matches 1.. run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2
execute if score @s cd_tank_crash matches 1.. run return 0

# 2. CT設定
scoreboard players set @s cd_tank_crash 200

# スニークジャンプ処理 (省略なし、そのまま記述)
execute if predicate my_pvp:is_sneaking run effect give @s minecraft:levitation 1 10 true
execute if predicate my_pvp:is_sneaking run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 0.6
execute if predicate my_pvp:is_sneaking run particle minecraft:cloud ~ ~ ~ 0.5 0 0.5 0.1 20
execute if predicate my_pvp:is_sneaking run return 1

# --- 以下、攻撃処理 ---

# 3. 演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 0.8
particle minecraft:explosion_emitter ~ ~ ~ 1 0 1 0 1
particle minecraft:campfire_signal_smoke ~ ~ ~ 3 0 3 0.1 50

# 4. ターゲット選定
scoreboard players operation #TEMP player_id = @s player_id
# 自分にタグをつけて攻撃者として識別可能にする
tag @s add current_attacker

tag @a remove crash_target
execute at @s as @a[distance=..5,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add crash_target

# 5. ダメージ処理 (修正版)
# 【修正】by @p[tag=current_attacker] で自分を攻撃元に指定
execute as @a[tag=crash_target] run damage @s 6 minecraft:player_explosion by @p[tag=current_attacker,limit=1]

# 6. 後始末
tag @a remove crash_target
tag @s remove current_attacker