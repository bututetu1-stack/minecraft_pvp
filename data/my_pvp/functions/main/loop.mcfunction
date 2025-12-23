# 常に「ポイント」を右側のサイドバーに表示（テスト用）
scoreboard objectives setdisplay sidebar points
# 試合中のみ実行
execute if score #GLOBAL match_state matches 1 run function my_pvp:main/game_logic

# --- game_logic.mcfunction を作成して以下を記述 ---
# 機械工本人の処理
execute as @a[tag=mechanic] run function my_pvp:roles/mechanic_main
# 設置物（ガジェット）の共通処理
execute as @e[tag=gadget] run function my_pvp:roles/gadget_tick