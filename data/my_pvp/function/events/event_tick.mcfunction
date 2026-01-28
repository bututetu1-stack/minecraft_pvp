# イベントメインループ
# 毎tick呼び出し (game_logicから)

# イベント発動チェック (1分, 2分, 3分, 4分)
# match_timer はカウントアップ (0 -> 6000)
# 1200, 2400, 3600, 4800 のタイミングで発火
# 告知 (10s = 200tick 前)
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 1000 run function my_pvp:events/announce_next
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 2200 run function my_pvp:events/announce_next
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 3400 run function my_pvp:events/announce_next
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 4600 run function my_pvp:events/announce_next

# イベント開始 (1200, 2400, 3600, 4800)
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 1200 run function my_pvp:events/start_next
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 2400 run function my_pvp:events/start_next
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 3600 run function my_pvp:events/start_next
execute if score #GLOBAL event_type matches 0 if score #GLOBAL match_timer matches 4800 run function my_pvp:events/start_next

# イベント中の場合 - 継続処理
execute if score #GLOBAL event_type matches 1 run function my_pvp:events/fog/tick
execute if score #GLOBAL event_type matches 2 run function my_pvp:events/low_gravity/tick
execute if score #GLOBAL event_type matches 3 run function my_pvp:events/bounty/tick
execute if score #GLOBAL event_type matches 4 run function my_pvp:events/sudden_death/tick
execute if score #GLOBAL event_type matches 5 run function my_pvp:events/rush_mode/tick
execute if score #GLOBAL event_type matches 6 run function my_pvp:events/night_battle/tick
execute if score #GLOBAL event_type matches 7 run function my_pvp:events/roulette/tick

# イベント終了判定
execute if score #GLOBAL event_type matches 1.. run scoreboard players remove #GLOBAL event_duration 1
execute if score #GLOBAL event_type matches 1.. if score #GLOBAL event_duration matches ..0 run function my_pvp:events/end_event
