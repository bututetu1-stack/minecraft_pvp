# バウンティイベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 賞金首に発光エフェクト
effect give @a[tag=bounty_target] minecraft:glowing 2 0 true

# キル判定 (賞金首が死んだか)
execute as @a[tag=bounty_target] at @s if score @s deaths > @s total_deaths run function my_pvp:events/bounty/kill_check
