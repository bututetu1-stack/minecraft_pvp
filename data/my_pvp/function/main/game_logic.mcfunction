# --- 1. プレイヤーの処理 ---
# --- Delayed Heal (Respawn Fix) ---
execute as @a[tag=pending_heal] run effect give @s minecraft:instant_health 1 100 true
execute as @a[tag=pending_heal] run effect give @s minecraft:saturation 1 255 true
tag @a[tag=pending_heal] remove pending_heal
# --- リスポーン検知 (Death Logic) ---
execute as @a[scores={deaths=1..}] run function my_pvp:system/respawn

# at @s を入れて、自身の位置を基準にする
execute as @a[tag=mechanic,tag=!is_frozen] at @s run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja,tag=!is_frozen] at @s run function my_pvp:roles/ninja/ninja_main
execute as @a[tag=scout,tag=!is_frozen] at @s run function my_pvp:roles/scout/scout_main
execute as @a[tag=tank,tag=!is_frozen] at @s run function my_pvp:roles/tank/tank_main
execute as @a[tag=berserker,tag=!is_frozen] at @s run function my_pvp:roles/berserker/berserker_main
execute as @a[tag=stalker,tag=!is_frozen] at @s run function my_pvp:roles/stalker/stalker_main
# ストーカー追撃(遅延処理) - Victimで実行
execute as @a[tag=sk_attack_target] run function my_pvp:roles/stalker/tick_attack_delay
execute as @a[tag=admiral,tag=!is_frozen] at @s run function my_pvp:roles/admiral/admiral_main
execute as @a[tag=chrono,tag=!is_frozen] at @s run function my_pvp:roles/chrono/chrono_main
execute as @a[tag=sculptor,tag=!is_frozen] at @s run function my_pvp:roles/sculptor/sculptor_main
execute as @a[tag=magician,tag=!is_frozen] at @s run function my_pvp:roles/magician/magician_main
execute as @a[tag=gambler,tag=!is_frozen] at @s run function my_pvp:roles/gambler/gambler_main
execute as @a[tag=samurai,tag=!is_frozen] at @s run function my_pvp:roles/samurai/samurai_main

# --- 時空跳躍者のグローバル処理 (フィールド・凍結制御) ---
# プレイヤーに関係なくサーバー全体で処理するため、as @a は付けずに呼び出す
function my_pvp:roles/chrono/global_tick

# --- ランダムイベント処理 ---
function my_pvp:events/event_tick

# --- 空腹度回復 (Saturation) ---
# Normal難易度になったため、常時満腹にして餓死を防ぐ
effect give @a minecraft:saturation 1 20 true

# 魔術師のアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/magician/scan_items

# 彫刻家のアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/sculptor/scan_items

# ギャンブラーのアイテムスキャン
# ギャンブラーのアイテムスキャン
# ギャンブラーのアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/gambler/scan_items

# ギャンブラー用ミニルーレット
execute as @e[tag=gambler_roulette_center] at @s run function my_pvp:roles/gambler/skills/roulette_tick

# 機械工のアイテムスキャン (追加)
execute as @e[type=item] at @s run function my_pvp:roles/mechanic/scan_items

# バーサーカーのアイテムスキャン (追加)
execute as @e[type=item] at @s run function my_pvp:roles/berserker/scan_items

# 忍者のアイテムスキャン (追加 - 必要なら)
execute as @e[type=item] at @s run function my_pvp:roles/ninja/scan_items

# 侍のアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/samurai/scan_items

# --- 3. ガジェットの処理 ---

# --- 3. ガジェット・エンティティ処理 ---
# ガジェット (タレット, 地雷など)
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic
execute as @e[tag=gadget_hitbox] at @s run function my_pvp:roles/mechanic/gadget_tic

# 忍者の身代わり
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick

# タレットの弾丸
execute as @e[tag=turret_shot] at @s run function my_pvp:roles/mechanic/turret_shot_tick

# --- 6. 魔術師の炎玉処理 ---
# armor_stand 弾を毎tick処理
execute as @e[type=armor_stand,tag=mag_fireball] at @s run function my_pvp:roles/magician/fireball_tick

# --- 7. 提督の攻撃処理 (Global) ---
execute as @e[tag=artillery_marker] at @s run function my_pvp:roles/admiral/tick_artillery
execute as @e[tag=adm_torpedo] at @s run function my_pvp:roles/admiral/tick_torpedo
execute as @e[tag=airstrike_center] at @s run function my_pvp:roles/admiral/process_airstrike
execute as @e[tag=adm_bomb] at @s run function my_pvp:roles/admiral/tick_bomb
# 提督ペナルティ(遅延処理)
execute as @a[tag=adm_penalty_target] run function my_pvp:roles/admiral/tick_penalty_delay

# 安全装置: 迷子ファントム処理
execute as @e[tag=adm_plane] at @s run function my_pvp:roles/admiral/tick_plane_safety

# --- 彫刻家の彫刻処理 (毎tick) ---
# パーティクル演出
execute as @e[tag=sculpture] at @s run function my_pvp:roles/sculptor/sculpture_tick
# 破壊判定
execute as @e[tag=sculpture_hitbox] at @s run function my_pvp:roles/sculptor/sculpture_destroy

# 【デバッグ】Hitbox生存確認
# execute as @e[tag=sculpture_hitbox] run tellraw @a {"text":"[DEBUG] I am Hitbox","color":"dark_gray"}

# 【追加】視線判定 (レイキャスト + FOV判定)
# 全プレイヤーが視線を飛ばして判定 (20m, 壁判定あり, 視野角あり)
execute as @a[gamemode=!spectator] at @s run function my_pvp:roles/sculptor/checker/main

# 【追加】彫刻関連のキル判定 (毒死など)
execute as @a[gamemode=!spectator] run function my_pvp:roles/sculptor/kill_check

# --- 7. スコアボード表示 ---

# --- 4. ゲーム進行管理 ---

# スコアボード表示
scoreboard objectives setdisplay sidebar points

# タイマー加算 (1tickに1加算)
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

# 【安全対策】定数・タイマーの強制初期化 (Setup忘れ対策)
execute unless score #4_CONST temp matches 4 run scoreboard players set #4_CONST temp 4
execute unless score #CONST_40 temp matches 40 run scoreboard players set #CONST_40 temp 40
execute unless score #CONST_10 temp matches 10 run scoreboard players set #CONST_10 temp 10
execute unless score #GLOBAL heal_timer matches 0.. run scoreboard players set #GLOBAL heal_timer 0

# --- 【追加】ボスバー更新処理 ---
# 1. 残り時間を計算用スコア(#CALC temp)に代入 (6000 - 現在経過時間)
scoreboard players set #CALC temp 6000
execute if score #GLOBAL match_state matches 1 run scoreboard players operation #CALC temp -= #GLOBAL match_timer

# 2. ボスバーに数値を反映
execute if score #GLOBAL match_state matches 1 run execute store result bossbar my_pvp:timer value run scoreboard players get #CALC temp

# 3. 演出: 残り1分(1200tick)を切ったら赤くする
execute if score #CALC temp matches ..1200 run bossbar set my_pvp:timer color red
execute if score #CALC temp matches 1201.. run bossbar set my_pvp:timer color yellow

# ポイント計算
execute as @a run scoreboard players operation @s points = @s kills
execute as @a run scoreboard players operation @s points *= #POINT_KILL temp
execute as @a run scoreboard players operation @s temp = @s total_deaths
execute as @a run scoreboard players operation @s temp *= #POINT_DEATH temp
execute as @a run scoreboard players operation @s points -= @s temp
execute as @a run scoreboard players operation @s points += @s bonus_points

# 試合終了判定 (6000 ticks = 5分)
execute if score #GLOBAL match_state matches 1 if score #GLOBAL match_timer matches 6000.. run function my_pvp:system/game_end


# --- 5. リスポーン時のステータス復旧 ---
# 死ぬと属性(Attribute)がリセットされ、最大HPが20に戻る仕様を利用してリスポーンを検知

# タンク (HP 70)
execute as @a[tag=tank,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:70.0d}]}] run function my_pvp:roles/tank/apply_status

# バーサーカー (HP 60)
execute as @a[tag=berserker,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:60.0d}]}] run function my_pvp:roles/berserker/apply_status

# 立体機動兵 (HP 40)
execute as @a[tag=scout,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/scout/apply_status

# 忍者 (HP 40)
execute as @a[tag=ninja,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/ninja/apply_status

# 機械工 (HP 40)
execute as @a[tag=mechanic,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/mechanic/apply_status

# ストーカー (HP 40 & ターゲット再抽選)
execute as @a[tag=stalker,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/stalker/apply_status

# 提督
execute as @a[tag=admiral,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/admiral/apply_status

# 魔術師 (HP 40)
execute as @a[tag=magician,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/magician/apply_status

# 【追加】 時空跳躍者 (HP 40)
execute as @a[tag=chrono,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/chrono/apply_status

# 【追加】 彫刻家 (HP 40)
execute as @a[tag=sculptor,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/sculptor/apply_status

# ギャンブラー (HP 40)
execute as @a[tag=gambler,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:40.0d}]}] run function my_pvp:roles/gambler/apply_status

# 侍 (HP 50)
execute as @a[tag=samurai,tag=!ignore_status_check] unless score #GLOBAL event_type matches 4 unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:50.0d}]}] run function my_pvp:roles/samurai/apply_status

# (既存のゲーム進行処理の後に追記)

# --- サドンデス中: HP強制1 (リスポーン対策) ---
# HPが1でないプレイヤーがいる場合のみ実行（ちらつき防止）
execute if score #GLOBAL event_type matches 4 as @a unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:1.0d}]}] run attribute @s minecraft:max_health base set 1
execute if score #GLOBAL event_type matches 4 as @a unless entity @s[nbt={attributes:[{id:"minecraft:max_health",base:1.0d}]}] run effect give @s minecraft:instant_health 1 0 true



# --- 5秒毎にHP回復 ---
# --- 5秒毎にHP回復 ---
# (カウントアップは main/loop で行うため削除)
# Debug: 100tickごとにメッセージ通知 + 回復 (Trigger check relies on loop increment)
# Note: Check logic is duplicate but harmless if loop handles reset. 
# BUT wait, loop handles reset too?
# Loop: increments, checks >100, resets.
# GameLogic: checks >100...
# If Loop resets it, GameLogic might miss it or run double?
# I should remove the ENTIRE regen block from game_logic, because loop handles it all now.

# --- ダメージ判定リセット (必ず最後) ---
scoreboard players reset @a damage_taken
