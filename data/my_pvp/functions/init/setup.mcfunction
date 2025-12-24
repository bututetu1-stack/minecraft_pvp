# --- 既存のスコア ---
scoreboard objectives add kills playerKillCount "キル数"
scoreboard objectives add deaths deathCount "デス数"
scoreboard objectives add points dummy "ポイント"

scoreboard objectives add match_timer dummy "残り時間"
scoreboard objectives add match_state dummy "試合状態"

scoreboard objectives add player_id dummy "PlayerID"
scoreboard objectives add temp dummy
scoreboard objectives add scrap dummy "スクラップ"

# --- クールダウン ---
scoreboard objectives add cooldown dummy "射撃CT"
scoreboard objectives add cd_turret dummy "タレットCT"
scoreboard objectives add cd_mine dummy "地雷CT"
scoreboard objectives add cd_launcher dummy "ランチャーCT"
scoreboard objectives add cd_snare dummy "スネアCT"

# 【追加】忍者用クールダウン
scoreboard objectives add cd_ninja_mark dummy "影縫いCT"
scoreboard objectives add cd_ninja_swap dummy "変わり身CT"
scoreboard objectives add cd_ninja_smoke dummy "煙玉CT"

# ガジェット耐久・寿命
scoreboard objectives add gadget_hp dummy "耐久値"
scoreboard objectives add gadget_life dummy "稼働時間"

# 【追加】忍者用システムスコア
# 右クリック検知 & 設置スロット管理
scoreboard objectives add click_skill minecraft.used:minecraft.carrot_on_a_stick "スキル使用"
scoreboard objectives add slot_cycle dummy "設置スロット"

# --- 初期値セット ---
scoreboard players set #GLOBAL match_state 0
scoreboard players set #NEXT_ID player_id 1
scoreboard players set #100 temp 100

scoreboard players set #POINT_KILL temp 10
scoreboard players set #POINT_DEATH temp 5