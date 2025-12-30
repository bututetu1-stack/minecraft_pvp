# --- 1. プレイヤーの処理 ---
# at @s を入れて、自身の位置を基準にする
execute as @a[tag=mechanic] at @s run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja] at @s run function my_pvp:roles/ninja/ninja_main
execute as @a[tag=scout] at @s run function my_pvp:roles/scout/scout_main
execute as @a[tag=tank] at @s run function my_pvp:roles/tank/tank_main
execute as @a[tag=berserker] at @s run function my_pvp:roles/berserker/berserker_main
execute as @a[tag=stalker] at @s run function my_pvp:roles/stalker/stalker_main
execute as @a[tag=admiral] at @s run function my_pvp:roles/admiral/admiral_main

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


# --- 3. ガジェット・エンティティ処理 ---
# ガジェット (タレット, 地雷など)
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic
execute as @e[tag=gadget_hitbox] at @s run function my_pvp:roles/mechanic/gadget_tic

# 忍者の身代わり
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick

# タレットの弾丸
execute as @e[tag=turret_shot] at @s run function my_pvp:roles/mechanic/turret_shot_tick


# --- 4. ゲーム進行管理 ---

# スコアボード表示
scoreboard objectives setdisplay sidebar points

# タイマー加算 (1tickに1加算)
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

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