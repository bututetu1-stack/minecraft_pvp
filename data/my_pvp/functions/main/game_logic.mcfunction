# --- 1. プレイヤーの処理 ---
# at @s を入れて、自身の位置を基準にする
execute as @a[tag=mechanic] at @s run function my_pvp:roles/mechanic/mechanic_main
execute as @a[tag=ninja] at @s run function my_pvp:roles/ninja/ninja_main
execute as @a[tag=scout] at @s run function my_pvp:roles/scout/scout_main
execute as @a[tag=tank] at @s run function my_pvp:roles/tank/tank_main

# バーサーカーのメイン処理
execute as @a[tag=berserker] at @s run function my_pvp:roles/berserker/berserker_main

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

# バーサーカーのアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/berserker/scan_items

# 魔術師のアイテムスキャン
execute as @e[type=item] at @s run function my_pvp:roles/magician/scan_items

# --- 3. ガジェットの処理 ---
execute as @e[tag=gadget] at @s run function my_pvp:roles/mechanic/gadget_tic
execute as @e[tag=gadget_hitbox] at @s run function my_pvp:roles/mechanic/gadget_tic

# --- 4. 忍者の身代わり処理 ---
execute as @e[tag=shadow_hitbox] at @s run function my_pvp:roles/ninja/shadow_tick

# --- 5. タレットの弾丸処理 ---
execute as @e[tag=turret_shot] at @s run function my_pvp:roles/mechanic/turret_shot_tick

# --- 6. 魔術師の炎玉処理 ---
execute as @e[type=small_fireball,tag=mag_fireball] at @s run function my_pvp:roles/magician/fireball_tick

# --- 7. スコアボード表示 ---
scoreboard objectives setdisplay sidebar points

# 7. 試合進行
execute if score #GLOBAL match_state matches 1 run scoreboard players add #GLOBAL match_timer 1

# --- ポイント計算 ---
execute as @a run scoreboard players operation @s points = @s kills
execute as @a run scoreboard players operation @s points *= #POINT_KILL temp
execute as @a run scoreboard players operation @s temp = @s deaths
execute as @a run scoreboard players operation @s temp *= #POINT_DEATH temp
execute as @a run scoreboard players operation @s points -= @s temp

# --- 試合終了判定 ---
execute if score #GLOBAL match_state matches 1 if score #GLOBAL match_timer matches 6000.. run function my_pvp:system/game_end

# --- リスポーン時のステータス復旧 ---

# タンク (HP 80) [修正: 40.0d -> 80.0d]
execute as @a[tag=tank] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:80.0d}]}] run function my_pvp:roles/tank/apply_status

# バーサーカー (HP 60) [修正: 30.0d -> 60.0d]
execute as @a[tag=berserker] unless entity @s[nbt={Attributes:[{Name:"minecraft:generic.max_health",Base:60.0d}]}] run function my_pvp:roles/berserker/apply_status
