# --- 1. プレイヤーの処理 ---
# at @s を入れて、自身の位置を基準にする
execute as @a[tag=mechanic] at @s run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja] at @s run function my_pvp:roles/ninja/ninja_main
execute as @a[tag=scout] at @s run function my_pvp:roles/scout/scout_main
execute as @a[tag=tank] at @s run function my_pvp:roles/tank/tank_main
execute as @a[tag=berserker] at @s run function my_pvp:roles/berserker/berserker_main
execute as @a[tag=stalker] at @s run function my_pvp:roles/stalker/stalker_main
execute as @a[tag=admiral] at @s run function my_pvp:roles/admiral/admiral_main

# 魔術師のメイン処理
execute as @a[tag=magician] at @s run function my_pvp:roles/magician/magician_main

# --- 空腹度回復 (Saturation) ---
# Normal難易度になったため、常時満腹にして餓死を防ぐ
effect give @a minecraft:saturation 1 20 true

# --- ゆっくり自動回復 (Slow Regen) ---
# 1. カウントアップ（生存者のみ）
execute as @a[gamemode=!spectator] run scoreboard players add @s regen_timer 1

# 2. 回復実行 (5秒ごとに0.5ハート回復)
execute as @a[scores={regen_timer=100..}] run effect give @s minecraft:regeneration 3 0 true
execute as @a[scores={regen_timer=100..}] run scoreboard players set @s regen_timer 0


# --- 2. アイテム処理（常時監視） ---
execute as @e[type=item] at @s run function my_pvp:roles/mechanic/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/ninja/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/scout/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/tank/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/berserker/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/stalker/scan_items
execute as @e[type=item] at @s run function my_pvp:roles/admiral/scan_items

# 魔術師のアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/magician/scan_items

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

# --- 7. スコアボード表示 ---

# --- 4. ゲーム進行管理 ---

# スコアボード表示
scoreboard objectives setdisplay sidebar points

# タイマー加算 (1tickに1加算)
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

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
execute as @a run scoreboard players operation @s temp = @s deaths
execute as @a run scoreboard players operation @s temp *= #POINT_DEATH temp
execute as @a run scoreboard players operation @s points -= @s temp

# 試合終了判定 (6000 ticks = 5分)
execute if score #GLOBAL match_state matches 1 if score #GLOBAL match_timer matches 6000.. run function my_pvp:system/game_end


# --- 5. リスポーン時のステータス復旧 ---
# 死ぬと属性(Attribute)がリセットされ、最大HPが20に戻る仕様を利用してリスポーンを検知

# タンク (HP 80)
execute as @a[tag=tank] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:80.0d}]}] run function my_pvp:roles/tank/apply_status

# バーサーカー (HP 60)
execute as @a[tag=berserker] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:60.0d}]}] run function my_pvp:roles/berserker/apply_status

# 立体機動兵 (HP 40)
execute as @a[tag=scout] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:40.0d}]}] run function my_pvp:roles/scout/apply_status

# 忍者 (HP 40)
execute as @a[tag=ninja] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:40.0d}]}] run function my_pvp:roles/ninja/apply_status

# 機械工 (HP 40)
execute as @a[tag=mechanic] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:40.0d}]}] run function my_pvp:roles/mechanic/apply_status

# ストーカー (HP 40 & ターゲット再抽選)
execute as @a[tag=stalker] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:40.0d}]}] run function my_pvp:roles/stalker/apply_status

# 提督
execute as @a[tag=admiral] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:40.0d}]}] run function my_pvp:roles/admiral/apply_status

# 魔術師 (HP 40)
execute as @a[tag=magician] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:40.0d}]}] run function my_pvp:roles/magician/apply_status

# (既存のゲーム進行処理の後に追記)

# ==========================================
# ▼▼▼ 全役職共通: 遅延ダメージ処理システム ▼▼▼

# 1. タイマー進行 (残り2tick以上の人を減らす)
execute as @a[scores={penalty_timer=2..}] run scoreboard players remove @s penalty_timer 1

# 2. ダメージ実行 (タイマーが1になった瞬間)
# 音と通知
execute as @a[scores={penalty_timer=1}] run tellraw @s {"text":"[!] 追加ダメージ","color":"red"}
execute as @a[scores={penalty_timer=1}] run playsound minecraft:entity.player.hurt master @s ~ ~ ~ 1 1.5

# ダメージ分岐 (scoresを1つにまとめました)
execute as @a[scores={penalty_timer=1,penalty_dmg=1}] run damage @s 1 minecraft:generic
execute as @a[scores={penalty_timer=1,penalty_dmg=2}] run damage @s 2 minecraft:generic
execute as @a[scores={penalty_timer=1,penalty_dmg=4}] run damage @s 4 minecraft:generic
execute as @a[scores={penalty_timer=1,penalty_dmg=6}] run damage @s 6 minecraft:generic
execute as @a[scores={penalty_timer=1,penalty_dmg=8..}] run damage @s 8 minecraft:generic

# 3. ループ防止タグの付与
execute as @a[scores={penalty_timer=1}] run tag @s add ignore_penalty_loop

# 4. 後処理 (リセット)
execute as @a[scores={penalty_timer=1}] run scoreboard players set @s penalty_dmg 0
execute as @a[scores={penalty_timer=1}] run scoreboard players set @s penalty_timer 0
