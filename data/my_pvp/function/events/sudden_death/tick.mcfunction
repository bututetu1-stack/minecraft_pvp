# サドンデスイベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 全員のHPを1に固定
# 全員の最大HPを1に固定

# 即時回復を入れて強制的に現在HPを更新
effect give @a minecraft:instant_health 1 0 true
