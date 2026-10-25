# --- ランダムリスポーン処理 ---

# 1. 共通ランダムスポーン処理を実行
function my_pvp:system/random_spawn

# 2. 死亡スコアをリセット (これをしないと無限にループします)
scoreboard players add @s total_deaths 1
scoreboard players set @s deaths 0

# 3. メッセージと演出
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"戦場へ復帰しました！","color":"yellow"}]
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1

# 4. 状態異常タグのリセット (バースト中やAll-In中に死んだ場合などの救済)
# 【追加】All-In自滅ペナルティ (さらに+1デスして合計-10点にする)
execute if entity @s[tag=all_in_suicide] run scoreboard players add @s total_deaths 1
execute if entity @s[tag=all_in_suicide] run tellraw @s [{"text":"[All-In] ","color":"red"},{"text":"自滅ペナルティが発生しました (-10 Points)","color":"gray"}]
execute if entity @s[tag=all_in_suicide] run tag @s add penalty_death
tag @s remove all_in_suicide

tag @s remove ignore_status_check
# バーサーカー: 空中で死んだ時のリープ/急降下状態 (残すとリスポーン後の着地でスラムが暴発する)
tag @s remove ber_ready
tag @s remove ber_falling
tag @s remove ber_slamming
tag @s remove bj_debuff
tag @s remove bj_debuff
scoreboard players set @s bj_debuff_timer 0

# 【修正】時空跳躍者の凍結バグ対策 (リスポーン時に強制解除)
function my_pvp:roles/chrono/freeze_end
tag @s remove is_frozen
tag @s remove has_anchor
tag @s remove tp_target

# 【追加】物理挙動の調整 (Gravity:0.105, Jump:0.6, Speed:1.1倍)
attribute @s minecraft:jump_strength base set 0.6
attribute @s minecraft:gravity base set 0.105
attribute @s minecraft:movement_speed base set 0.11

# 【修正】ノックバック力の異常対策 (初期値に戻す)
attribute @s minecraft:attack_knockback base set 0

# リスポーン時のパラメータ復元 (死亡でタグが消える/keepInventoryの影響対策)
execute if score @s role_id matches 1 run tag @s add mechanic
execute if score @s role_id matches 2 run tag @s add ninja
execute if score @s role_id matches 3 run tag @s add scout
execute if score @s role_id matches 4 run tag @s add tank
execute if score @s role_id matches 5 run tag @s add berserker
execute if score @s role_id matches 6 run tag @s add magician
execute if score @s role_id matches 7 run tag @s add stalker
execute if score @s role_id matches 8 run tag @s add admiral
execute if score @s role_id matches 9 run tag @s add chrono
execute if score @s role_id matches 10 run tag @s add sculptor
execute if score @s role_id matches 11 run tag @s add gambler
execute if score @s role_id matches 12 run tag @s add samurai
execute if score @s role_id matches 13 run tag @s add sharpshooter
execute if score @s role_id matches 14 run tag @s add beastmaster

# (オプション) もしリスポーン時に特定のアイテムを再配布したい場合はここに記述
# リスポーン時のアイテム・コスト補充 (魔術師, 機械工, ギャンブラー)
execute if entity @s[tag=magician] run function my_pvp:system/give_magician_items

# 提督 リスポーン時に被ダメ delta スナップショットを更新 (リスポーン直後の偽トリガー防止)
execute if entity @s[tag=admiral] run scoreboard players operation @s last_admiral_damage_taken = @s damage_taken
execute if entity @s[tag=admiral] run scoreboard players set @s penalty_timer 0
execute if entity @s[tag=admiral] run scoreboard players set @s penalty_dmg 0
execute if entity @s[tag=admiral] run tag @s remove adm_penalty_target
execute if entity @s[tag=magician] run scoreboard players set @s cd_mag_shockwave 0
execute if entity @s[tag=magician] run scoreboard players set @s cd_mag_inferno 0
execute if entity @s[tag=mechanic] run function my_pvp:system/give_mechanic_items
execute if entity @s[tag=gambler] run function my_pvp:system/give_gambler_items
execute if entity @s[tag=samurai] run function my_pvp:system/give_samurai_items
execute if entity @s[tag=samurai] run scoreboard players set @s cd_sam_zanshin 0
execute if entity @s[tag=samurai] run scoreboard players set @s cd_sam_iai 0
execute if entity @s[tag=samurai] run scoreboard players set @s cd_sam_hien 0
execute if entity @s[tag=samurai] run tag @s remove sam_zanshin_guard
execute if entity @s[tag=samurai] run tag @s remove sam_iai_dashing
execute if entity @s[tag=samurai] run tag @s remove sam_iai_hit_this_dash

# 狙撃手 リスポーン時アイテム再配布 + 残弾満タン
execute if entity @s[tag=sharpshooter] run function my_pvp:system/give_sharpshooter_items
execute if entity @s[tag=sharpshooter] run scoreboard players set @s sharp_ammo 10
execute if entity @s[tag=sharpshooter] run scoreboard players set @s sharp_ammo_timer 0
execute if entity @s[tag=sharpshooter] run tag @s remove sharp_focused

# ストーカー リスポーン時アイテム再配布 + コンパス変化検知リセット
execute if entity @s[tag=stalker] run function my_pvp:system/give_stalker_items
execute if entity @s[tag=stalker] run scoreboard players set @s last_compass_x 999999
execute if entity @s[tag=stalker] run scoreboard players set @s last_compass_z 999999
execute if entity @s[tag=stalker] run scoreboard players set @s compass_force_timer 0

# 獣使い リスポーン時アイテム再配布 + CTリセット
execute if entity @s[tag=beastmaster] run function my_pvp:system/give_beastmaster_items
execute if entity @s[tag=beastmaster] run scoreboard players set @s cd_beast_wolf 0
execute if entity @s[tag=beastmaster] run scoreboard players set @s cd_beast_roar 0
execute if entity @s[tag=beastmaster] run scoreboard players set @s cd_beast_unleash 0

# ギャンブラーのコイン管理
# - All-In 自滅 (penalty_death): 0
# - 運命のコインで破産 (bankrupt_death): 10
# - それ以外: 50
# ※ コインはここでだけ決める (以前は apply_status でも 50 に上書きしており、ペナルティが効いていなかった)
execute if entity @s[tag=gambler] run scoreboard players set @s coins 50
execute if entity @s[tag=gambler,tag=bankrupt_death] run scoreboard players set @s coins 10
execute if entity @s[tag=gambler,tag=bankrupt_death,tag=!penalty_death] run tellraw @s {"text":"[Fate] 破産ペナルティ... (所持金 10)","color":"red"}
execute if entity @s[tag=gambler,tag=penalty_death] run scoreboard players set @s coins 0

# ペナルティタグ解除
tag @s remove penalty_death
tag @s remove bankrupt_death