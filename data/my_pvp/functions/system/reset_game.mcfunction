# --- 全員のスコアを完全リセット ---
# @a (オンラインのみ) ではなく * (全データ) を指定することで、
# サーバーにいないプレイヤーの記録も消します
scoreboard players reset * kills
scoreboard players reset * deaths
scoreboard players reset * points
scoreboard players reset * scrap

# クールダウン系リセット
scoreboard players reset * cd_turret
scoreboard players reset * cd_mine
scoreboard players reset * cd_launcher
scoreboard players reset * cd_snare
# 忍者用CTリセット
scoreboard players reset * cd_ninja_mark
scoreboard players reset * cd_ninja_swap
scoreboard players reset * cd_ninja_smoke
# タンク用リセット
scoreboard players reset * cd_tank_crash

# 【追加】バーサーカー用CTリセット
scoreboard players reset * cd_ber_raid
scoreboard players reset * cd_ber_jump
scoreboard players reset * last_kills

# 【追加】魔術師用リセット
scoreboard players reset * mana
scoreboard players reset * cd_mag_broom
scoreboard players reset * cd_mag_book
scoreboard players reset * mag_fly_tick

# 【追加】ストーカー用CT・変数リセット
scoreboard players reset * cd_stalker_float
scoreboard players reset * target_check_timer
scoreboard players reset * target_id

# ▼▼▼ 追加: 提督用CTリセット ▼▼▼
scoreboard players reset * cd_adm_artillery
scoreboard players reset * cd_adm_torpedo
scoreboard players reset * cd_adm_air
scoreboard players reset * cd_adm_aa
scoreboard players reset * ammo
scoreboard players reset * timer
# --- 提督 & 汎用システムのスコアリセット ---
scoreboard players reset @a damage_taken
scoreboard players reset @a adm_formation
scoreboard players reset @a cd_formation

# 時空跳躍者用リセット
scoreboard players set @a cd_chrono_reverse 0
scoreboard players set @a cd_chrono_stasis 0
scoreboard players set @a cd_chrono_clockup 0
scoreboard players set @a freeze_timer 0
scoreboard players set @a timer 0
scoreboard players set @a stasis_timer 0
tag @a remove stasis_caster

# 彫刻家用リセット
scoreboard players set @a sculpture_count 0
scoreboard players set @a cd_sculptor_create 0
scoreboard players set @a sculpture_cycle 1

# 【修正】全員の基礎HPを 20 -> 40 に変更
execute as @a run attribute @s minecraft:generic.max_health base set 40
execute as @a run attribute @s minecraft:generic.knockback_resistance base set 0

# システム用IDなどもリセット
scoreboard players reset * player_id
scoreboard players reset * temp

# インベントリクリア (@a: オンラインのみ)
clear @a

# エフェクトクリア
effect clear @a

# 試合開始の瞬間にHPと満腹度をMAXにする
effect give @a minecraft:instant_health 1 100 true
effect give @a minecraft:saturation 1 255 true

# 役職タグリセット
tag @a remove role_assigned
tag @a remove mechanic
tag @a remove ninja
tag @a remove scout
tag @a remove tank
tag @a remove berserker
tag @a remove magician
tag @a remove mag_flying_true
tag @a remove stalker
tag @a remove admiral
tag @a remove target_candidate
tag @a remove chrono
tag @a remove is_frozen
tag @a remove sculptor

# --- 計算用の一時タグを全消去 ---
tag @a remove owner_temp
tag @a remove stepping_enemy
tag @a remove sentry_target
tag @a remove potential_target
tag @a remove shot_hit
tag @a remove launcher_target
tag @a remove current_caster
tag @a remove current_attacker
tag @a remove item_recipient
# 【追加】提督用一時タグ
tag @a remove attacker_temp
tag @a remove using_skill

tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money
# 【追加】ストーカーの一時タグ削除
tag @a remove my_target
tag @a remove is_my_target

# 攻撃力を標準(1.0)に戻す
execute as @a run attribute @s minecraft:generic.attack_damage base set 1

# --- ドロップ防止処理 ---
execute as @e[tag=gadget_visual] run data merge entity @s {HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
execute as @e[tag=ninja_shadow] run data merge entity @s {HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
execute as @e[tag=launcher] run data merge entity @s {ArmorItems:[{},{},{},{}]}

# 設置されたガジェット・くじ・カード等を全消去
kill @e[tag=gadget]
kill @e[tag=gadget_hitbox]
kill @e[tag=role_card]
kill @e[tag=ninja_shadow]
kill @e[tag=shadow_hitbox]

# 魔術師の炎玉を消去
kill @e[type=armor_stand,tag=mag_fireball]

# ダメージ判定用プロキシを消去
kill @e[tag=dmg_proxy]

# ▼▼▼ 追加: 提督用エンティティ消去 ▼▼▼
# 砲撃マーカー
kill @e[tag=artillery_marker]
kill @e[tag=new_marker]
# 魚雷
kill @e[tag=adm_torpedo]
kill @e[tag=new_torp]
# 航空支援
kill @e[tag=airstrike_center]
kill @e[tag=adm_plane]
kill @e[tag=temp_air_marker]
# 爆弾
kill @e[tag=adm_bomb]
kill @e[tag=new_bomb]

# 【追加】 時空跳躍者のマーカー削除
# 過去位置マーカー
kill @e[tag=chrono_marker]
# 時空の静止フィールド
kill @e[tag=stasis_center]

# 【追加】 彫刻家のエンティティ削除
execute as @e[tag=sculpture] run data merge entity @s {HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
kill @e[tag=sculpture]
kill @e[tag=sculpture_hitbox]

# 【追加】 ギャンブラー用リセット
scoreboard players reset * coins
scoreboard players reset * coins_timer
scoreboard players reset * bj_action
scoreboard players reset * bj_dealer
scoreboard players reset * bj_hand
scoreboard players reset * bj_state
scoreboard players reset * bj_timer
scoreboard players reset * bj_debuff_timer
scoreboard players reset * bj_hit_cd
scoreboard players reset * roulette_timer
scoreboard players reset * skill_gambler_war
scoreboard players reset * damage_boost

tag @a remove gambler
tag @a remove bj_debuff

kill @e[tag=roulette_marker]


# 残留アイテムの完全消去
kill @e[type=item]

# タイマーリセット
scoreboard players set #GLOBAL match_timer 0
scoreboard players set #GLOBAL match_state 0