# バウンティイベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 賞金首に発光エフェクト
effect give @a[tag=bounty_target] minecraft:glowing 2 0 true

# キル判定: advancement (player_killed_entity) で +50pt は付与済み
# ここでは賞金首が死んだら bounty_target タグを除去するだけ
execute as @a[tag=bounty_target] if score @s deaths > @s total_deaths run tag @s remove bounty_target
