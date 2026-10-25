# バウンティイベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 賞金首に発光エフェクト
effect give @a[tag=bounty_target] minecraft:glowing 2 0 true

# キル判定は game_logic の冒頭 (respawn より前) で行う
