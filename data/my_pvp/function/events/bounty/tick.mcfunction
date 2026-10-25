# バウンティイベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 賞金首に発光エフェクト
effect give @a[tag=bounty_target] minecraft:glowing 2 0 true

# キル判定: +50pt は advancement (bounty_killed -> award_killer) で付与
# 賞金首の死亡によるタグ除去は game_logic の冒頭 (respawn が deaths を 0 に戻す前) で行う
