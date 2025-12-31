# --- 既存のスコア ---
scoreboard objectives add kills playerKillCount "キル数"
scoreboard objectives add deaths deathCount "デス数"
scoreboard objectives add points dummy "ポイント"

scoreboard objectives add match_timer dummy "残り時間"
scoreboard objectives add match_state dummy "試合状態"

scoreboard objectives add player_id dummy "PlayerID"
scoreboard objectives add temp dummy
scoreboard objectives add scrap dummy "スクラップ"
scoreboard objectives add regen_timer dummy "回復タイマー"

scoreboard objectives add timer dummy
scoreboard objectives add ammo dummy
scoreboard objectives add temp dummy

# --- クールダウン ---
#機械工用クールダウン
scoreboard objectives add cooldown dummy "射撃CT"
scoreboard objectives add cd_turret dummy "タレットCT"
scoreboard objectives add cd_mine dummy "地雷CT"
scoreboard objectives add cd_launcher dummy "ランチャーCT"
scoreboard objectives add cd_snare dummy "スネアCT"

# 忍者用クールダウン
scoreboard objectives add cd_ninja_mark dummy "影縫いCT"
scoreboard objectives add cd_ninja_swap dummy "変わり身CT"
scoreboard objectives add cd_ninja_smoke dummy "煙玉CT"

#スカウト用クールダウン
scoreboard objectives add cd_wire dummy "ワイヤーCT"

# タンク用クールダウン
scoreboard objectives add cd_tank_crash dummy "クラッシュCT"

# タンク用スキル検知 (歪んだキノコ付きの棒)
scoreboard objectives add click_tank minecraft.used:minecraft.warped_fungus_on_a_stick "タンクスキル"

# バーサーカー用クールダウン
scoreboard objectives add cd_ber_raid dummy "ブラッドレイドCT"
scoreboard objectives add cd_ber_jump dummy "ジャンプCT"

# バーサーカー用判定
scoreboard objectives add click_ber_raid minecraft.used:minecraft.iron_axe "レイド発動"
scoreboard objectives add click_ber_jump minecraft.used:minecraft.feather "ジャンプ発動"

# 魔術師用クールダウン
scoreboard objectives add mana dummy "マナ"
scoreboard objectives add cd_mag_broom dummy "魔術箻CT"
scoreboard objectives add cd_mag_book dummy "魔術本CT"
scoreboard objectives add mag_fly_tick dummy "飛行タイマー"

# 魔術師用スキル検知
scoreboard objectives add click_mag_broom minecraft.used:minecraft.stick "魔術箻使用"
scoreboard objectives add click_mag_book minecraft.used:minecraft.book "魔術本使用"

# 【追加】キル検知用（回復処理に使用）
scoreboard objectives add last_kills dummy "前回のキル数"

# ガジェット耐久・寿命
scoreboard objectives add gadget_hp dummy "耐久値"
scoreboard objectives add gadget_life dummy "稼働時間"

# 忍者用システムスコア
# 右クリック検知 & 設置スロット管理
scoreboard objectives add click_skill minecraft.used:minecraft.carrot_on_a_stick "スキル使用"
scoreboard objectives add slot_cycle dummy "設置スロット"

# スカウトシステムスコア
# サウンド間隔制御用
scoreboard objectives add sound_ticker dummy

# ストーカー用
scoreboard objectives add cd_stalker_float dummy
# 【追加】ターゲット管理用
scoreboard objectives add target_id dummy "ターゲットID"
scoreboard objectives add target_check_timer dummy "ターゲット確認タイマー"

# 【追加】攻撃判定用 (ダメージを与えたかを検知)
scoreboard objectives add damage_dealt minecraft.custom:minecraft.damage_dealt "与ダメージ"
scoreboard objectives add last_damage_dealt dummy "前回与ダメージ"

# --- 提督 (Admiral) 用 ---
# クールダウン
scoreboard objectives add cd_adm_artillery dummy "砲撃支援CT"
scoreboard objectives add cd_adm_torpedo dummy "魚雷CT"
scoreboard objectives add cd_adm_air dummy "航空支援CT"
scoreboard objectives add cd_adm_aa dummy "対空CT"

# --- 初期値セット ---
scoreboard players set #GLOBAL match_state 0
scoreboard players set #NEXT_ID player_id 1
scoreboard players set #100 temp 100
scoreboard players set #20 temp 20

scoreboard players set #POINT_KILL temp 10
scoreboard players set #POINT_DEATH temp 5

# --- アイテムドロップ検知用 ---
scoreboard objectives add drop_sword dropped:iron_sword "忍刀ドロップ"
scoreboard objectives add drop_dye dropped:black_dye "影縫いドロップ"
scoreboard objectives add drop_coal dropped:charcoal "煙玉ドロップ"
scoreboard objectives add drop_rod dropped:carrot_on_a_stick "杖ドロップ"

# --- 【修正】ワールド初期設定 ---
# 落下ダメージ無効
gamerule fallDamage false
gamerule drowningDamage false

# 【修正】難易度をNormalに変更（爆発ダメージを有効にするため）
difficulty normal

# 【追加】モブが湧かないように設定
gamerule doMobSpawning false

# HP自然回復の停止 (空腹ゲージが満タンでも回復しない)
gamerule naturalRegeneration false

# 死亡時のアイテムドロップを無効化（インベントリを保持）
gamerule keepInventory true

# 常に昼に固定する（時間停止と現在時刻を昼に設定）
gamerule doDaylightCycle false
time set day
# --- ボーダー設定用トリガー ---
scoreboard objectives add border_distance trigger "ボーダー距離"
# 新規参加プレイヤー向けにトリガーを有効化
scoreboard players enable @a border_distance
## ボーダー中心の半径保存用スコア
scoreboard objectives add border_radius dummy "ボーダー半径"
scoreboard objectives add last_death dummy "前回のデス数"
# 初期化: 現在の deaths を last_death にコピー
execute as @a run scoreboard players operation @s last_death = @s deaths
