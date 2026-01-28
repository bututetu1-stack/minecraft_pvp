# 0. 自傷ダメージ (Cost: 4HP)
damage @s 4 minecraft:magic

# 1. 演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 0.8
particle minecraft:explosion_emitter ~ ~ ~ 1 0 1 0 1
# 衝撃波エフェクト
execute at @s run particle dust{color:[0.8,0.0,0.0],scale:2.0} ~ ~0.2 ~ 3 0.1 3 1 100 normal
execute at @s run particle minecraft:cloud ~ ~0.5 ~ 2 0.2 2 0.1 50
# 2. ターゲット選定
scoreboard players operation #TEMP player_id = @s player_id
# 自分を攻撃者としてマーク
tag @s add current_attacker

tag @a remove slam_target
execute as @a[distance=..4,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add slam_target

# 3. ダメージ付与 (修正版)
# 【修正】by @p[tag=current_attacker] を使用
execute as @a[tag=slam_target] run damage @s 8 minecraft:player_attack by @p[tag=current_attacker,limit=1]


# 5. 後始末
tag @a remove slam_target
tag @s remove current_attacker
tag @s remove ber_leaping
tag @s remove ber_slamming