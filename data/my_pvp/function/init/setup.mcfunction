# --- 既存のスコア ---
scoreboard objectives add kills playerKillCount "キル数"
scoreboard objectives add deaths deathCount "デス数"
scoreboard objectives add points dummy "ポイント"
scoreboard objectives add bonus_points dummy "Bonus Points"

# 【追加】累計デス数 (ポイント計算用)
scoreboard objectives add total_deaths dummy "Total Deaths"

scoreboard objectives add match_timer dummy "残り時間"
scoreboard objectives add match_state dummy "試合状態"

scoreboard objectives add player_id dummy "PlayerID"
scoreboard objectives add role_id dummy "RoleID"
scoreboard objectives add temp dummy
scoreboard objectives add scrap dummy "スクラップ"
scoreboard objectives add regen_timer dummy "回復タイマー"
# スポーン位置の再抽選回数 (system/random_spawn, check_spawn)
scoreboard objectives add retry_count dummy "スポーン再抽選回数"

scoreboard objectives add timer dummy
scoreboard objectives add coins_timer dummy
scoreboard objectives add bj_debuff_timer dummy
scoreboard objectives add ammo dummy
scoreboard objectives add health health "HP"
scoreboard objectives add hp_snapshot dummy "HP Snapshot"

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
scoreboard objectives add cd_shield_bash dummy "シールドバッシュCT"

# タンク用スキル検知
scoreboard objectives add click_tank minecraft.used:minecraft.warped_fungus_on_a_stick "タンクスキル"
scoreboard objectives add start_shield_bash minecraft.used:minecraft.paper "バッシュ開始"
scoreboard objectives add shield_dash_timer dummy "バッシュ時間"

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
scoreboard objectives add trail_timer dummy "痕跡タイマー"
# 遅延攻撃 (trigger_attack -> tick_attack_delay) 用
scoreboard objectives add sk_attack_timer dummy "追撃タイマー"

# 【追加】攻撃判定用 (ダメージを与えたかを検知)
scoreboard objectives add damage_dealt minecraft.custom:minecraft.damage_dealt "与ダメージ"
scoreboard objectives add last_damage_dealt dummy "前回与ダメージ"

# --- 提督 (Admiral) 用 ---
# クールダウン
scoreboard objectives add cd_adm_artillery dummy "砲撃支援CT"
scoreboard objectives add cd_adm_torpedo dummy "魚雷CT"
scoreboard objectives add cd_adm_air dummy "航空支援CT"
scoreboard objectives add cd_adm_aa dummy "対空CT"
scoreboard objectives add adm_formation dummy "陣形ID"
scoreboard objectives add cd_formation dummy "陣形CT"
scoreboard objectives add click_formation minecraft.used:minecraft.recovery_compass "羅針盤使用"

# 被ダメージ検知用 (提督の警戒陣などで使用)
scoreboard objectives add damage_taken minecraft.custom:minecraft.damage_taken
# 警戒陣ペナルティ用
scoreboard objectives add penalty_timer dummy
scoreboard objectives add penalty_dmg dummy
scoreboard objectives add penalty_attacker dummy

# --- 時空跳躍者 (Chronomancer) 用 ---
# 【追加】 個別CT用スコア
scoreboard objectives add cd_chrono_reverse dummy
scoreboard objectives add cd_chrono_stasis dummy
scoreboard objectives add cd_chrono_clockup dummy
scoreboard objectives add freeze_timer dummy
scoreboard objectives add stasis_timer dummy "時間停止タイマー"

# --- 彫刻家 (Sculptor) 用 ---
scoreboard objectives add sculpture_count dummy "彫刻設置数"
scoreboard objectives add cd_sculptor_create dummy "彫刻生成CT"
scoreboard objectives add sculpture_cycle dummy "彫刻サイクル"
scoreboard objectives add sculpture_slot dummy "彫刻スロット"
scoreboard objectives add sculpture_hp dummy "彫刻HP"

# --- 初期値セット ---
scoreboard players set #GLOBAL match_state 0
scoreboard players set #NEXT_ID player_id 1
scoreboard players set #100 temp 100
scoreboard players set #100 temp 100
scoreboard players set #20 temp 20
scoreboard players set #4_CONST temp 4
scoreboard players set #CONST_3 temp 3
scoreboard players set #CONST_10 temp 10
scoreboard players set #GLOBAL regen_timer 0

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

# --- 彫刻家 (Sculptor) 用 (追加分) ---
scoreboard objectives add last_attacker_id dummy "ラストアタッカー"
scoreboard objectives add sculptor_hit_timer dummy "彫刻ヒットタイマー"


# --- ギャンブラー (Gambler) 用 ---
scoreboard objectives add coins dummy "コイン"
scoreboard objectives add bj_action trigger "BJアクション"
scoreboard objectives add bj_dealer dummy "BJディーラー手札"
scoreboard objectives add bj_hand dummy "BJプレイヤー手札"
scoreboard objectives add bj_state dummy "BJ状態"
scoreboard objectives add bj_timer dummy "BJタイマー"
scoreboard objectives add roulette_timer dummy "ルーレットタイマー"
scoreboard objectives add skill_gambler_war dummy "戦争フラグ"
scoreboard objectives add damage_boost dummy "ダメ増フラグ"
scoreboard objectives add bj_hit_cd dummy "被ダメ増CT"
scoreboard objectives add fate_pot dummy "賭け金"
scoreboard objectives add fate_streak dummy "継続数"
scoreboard objectives add fate_timer dummy "Fateタイマー"

# アイテム検知用
# 鉄インゴット(BJ)
scoreboard objectives add drop_iron dropped:iron_ingot "BJ起動"
# 金塊(All-In)
scoreboard objectives add drop_gold dropped:gold_nugget "AllIn起動"
# ガストの涙(Roulette)
scoreboard objectives add drop_tear dropped:ghast_tear "ルーレット起動"
# 銅インゴット(Coin)
scoreboard objectives add drop_copper dropped:copper_ingot "コイン起動"
# 赤色の染料(War)
scoreboard objectives add drop_red_dye dropped:red_dye "戦争起動"


# --- 共有スキル (Super Jump) 用 ---
scoreboard objectives add sneak_time minecraft.custom:minecraft.sneak_time "スニーク時間"
scoreboard objectives add cd_super_jump dummy "大ジャンプCT"

# --- 侍 (Samurai) 用 ---
scoreboard objectives add cd_sam_zanshin dummy "残心CT"
scoreboard objectives add cd_sam_iai dummy "居合CT"
scoreboard objectives add cd_sam_hien dummy "飛燕CT"
scoreboard objectives add sam_zanshin_active dummy "残心構え時間"
scoreboard objectives add sam_iai_active dummy "居合突進時間"
# 残心の構え検知 (samurai_blocking 進捗が構え中の毎tick 1 にする)
scoreboard objectives add sam_blocking dummy "残心構え検知"

# --- タイマー用ボスバーの作成 ---
bossbar add my_pvp:timer {"text":"残り時間","color":"yellow","bold":true}
bossbar set my_pvp:timer style progress
bossbar set my_pvp:timer max 6000

# --- ランダムイベント用 ---
scoreboard objectives add event_timer dummy "イベントタイマー"
scoreboard objectives add event_duration dummy "イベント持続時間"
scoreboard objectives add event_type dummy "イベントタイプ"
scoreboard objectives add bounty_target dummy "賞金首ID"
# インフレーション: 開始時点のキル数
scoreboard objectives add infl_kills dummy "インフレ開始時キル"

# ルーレット用
scoreboard objectives add sector_offset dummy "セクターオフセット"
scoreboard objectives add part_radius dummy "パーツ半径"
# ルーレット用 (追加)
scoreboard objectives add last_sector dummy "前回のセクター"