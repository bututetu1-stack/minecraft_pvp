# --- 1. 基本スコア ---
scoreboard objectives add kills playerKillCount "キル数"
scoreboard objectives add deaths deathCount "デス数"
scoreboard objectives add points dummy "ポイント"

# --- 2. ゲーム管理 ---
scoreboard objectives add match_timer dummy "残り時間"
scoreboard objectives add match_state dummy "試合状態"

# --- 3. システム・機械工用 ---
scoreboard objectives add player_id dummy "PlayerID"
scoreboard objectives add temp dummy
scoreboard objectives add scrap dummy "スクラップ"

# --- 4. 初期値セット ---
scoreboard players set #GLOBAL match_state 0
# IDを1から始めるための準備
scoreboard players set #NEXT_ID player_id 1

#計算用定数
scoreboard players set #100 temp 100