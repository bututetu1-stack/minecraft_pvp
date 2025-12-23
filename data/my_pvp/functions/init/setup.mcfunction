# --- 既存の内容 ---
scoreboard objectives add kills playerKillCount "キル数"
scoreboard objectives add deaths deathCount "デス数"
scoreboard objectives add points dummy "ポイント"

scoreboard objectives add match_timer dummy "残り時間"
scoreboard objectives add match_state dummy "試合状態"

scoreboard objectives add player_id dummy "PlayerID"
scoreboard objectives add temp dummy
scoreboard objectives add scrap dummy "スクラップ"

scoreboard objectives add cooldown dummy "射撃CT"
scoreboard objectives add cd_turret dummy "タレットCT"
scoreboard objectives add cd_mine dummy "地雷CT"
scoreboard objectives add cd_launcher dummy "ランチャーCT"
scoreboard objectives add cd_snare dummy "スネアCT"

scoreboard objectives add gadget_hp dummy "耐久値"
scoreboard objectives add gadget_life dummy "稼働時間"

scoreboard players set #GLOBAL match_state 0
scoreboard players set #NEXT_ID player_id 1
scoreboard players set #100 temp 100

# --- 【追加】ポイント計算用倍率 ---
# キル +10点, デス -5点
scoreboard players set #POINT_KILL temp 10
scoreboard players set #POINT_DEATH temp 5