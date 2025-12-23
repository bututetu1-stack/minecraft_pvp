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

# クールダウン管理用
scoreboard objectives add cooldown dummy "射撃CT"
scoreboard objectives add cd_turret dummy "タレットCT"
scoreboard objectives add cd_mine dummy "地雷CT"
scoreboard objectives add cd_launcher dummy "ランチャーCT"
# 【追加】スネアCT
scoreboard objectives add cd_snare dummy "スネアCT"

# ガジェット耐久値
scoreboard objectives add gadget_hp dummy "耐久値"
# 【追加】ガジェット稼働時間（スネアの寿命用）
scoreboard objectives add gadget_life dummy "稼働時間"

# --- 4. 初期値セット ---
scoreboard players set #GLOBAL match_state 0
scoreboard players set #NEXT_ID player_id 1
scoreboard players set #100 temp 100