# --- 1. 基本的な戦闘スタッツ ---
# キル数とデス数はマイクラが自動でカウントしてくれます
scoreboard objectives add kills playerKillCount "キル数"
scoreboard objectives add deaths deathCount "デス数"
# 計算後の最終ポイント
scoreboard objectives add points dummy "ポイント"

# --- 2. ゲーム進行管理 ---
# 残り時間（tick単位: 20tick = 1秒）
scoreboard objectives add match_timer dummy "残り時間"
# 試合の状態（0: 待機中, 1: 試合中, 2: 終了・集計）
scoreboard objectives add match_state dummy "試合状態"

# --- 3. システム・ロジック用 ---
# プレイヤーごとの固有ID（機械工のガジェット所有者判定などに使用）
scoreboard objectives add player_id dummy "PlayerID"
# 計算用の一時的なスコア
scoreboard objectives add temp dummy

# --- 4. 初期設定 ---
# 試合状態を「待機中(0)」にセット
scoreboard players set #GLOBAL match_state 0