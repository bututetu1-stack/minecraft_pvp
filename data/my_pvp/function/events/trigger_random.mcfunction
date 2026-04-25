# ランダムイベント選択 (即時発動版)
# 既存イベントがあれば終了
execute if score #GLOBAL event_type matches 1.. run function my_pvp:events/end_event

scoreboard players set #GLOBAL event_timer 0

# 重複なし抽選
scoreboard players set #ROLL_RETRY temp 0
function my_pvp:events/roll_next_event

# イベントタイプ設定
scoreboard players operation #GLOBAL event_type = #NEXT_EVENT_TYPE temp

# 継続時間設定 (40秒 = 800tick)
scoreboard players set #GLOBAL event_duration 800

# 各イベント開始処理
execute if score #GLOBAL event_type matches 1 run function my_pvp:events/fog/start
execute if score #GLOBAL event_type matches 2 run function my_pvp:events/low_gravity/start
execute if score #GLOBAL event_type matches 3 run function my_pvp:events/bounty/start
execute if score #GLOBAL event_type matches 4 run function my_pvp:events/sudden_death/start
execute if score #GLOBAL event_type matches 5 run function my_pvp:events/rush_mode/start
execute if score #GLOBAL event_type matches 6 run function my_pvp:events/night_battle/start
execute if score #GLOBAL event_type matches 7 run function my_pvp:events/roulette/start
execute if score #GLOBAL event_type matches 8 run function my_pvp:events/inflation/start
