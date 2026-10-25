# ラッシュモードイベント継続処理
scoreboard players remove #GLOBAL event_duration 1

# 全員のクールダウンを0にリセット
scoreboard players set @a cd_turret 0
scoreboard players set @a cd_mine 0
scoreboard players set @a cd_launcher 0
scoreboard players set @a cd_snare 0
scoreboard players set @a cd_ninja_mark 0
scoreboard players set @a cd_ninja_swap 0
scoreboard players set @a cd_ninja_smoke 0
scoreboard players set @a cd_wire 0
scoreboard players set @a cd_tank_crash 0
scoreboard players set @a cd_shield_bash 0
scoreboard players set @a cd_ber_raid 0
scoreboard players set @a cd_ber_jump 0
scoreboard players set @a cd_mag_broom 0
scoreboard players set @a cd_mag_book 0
scoreboard players set @a cd_mag_shockwave 0
scoreboard players set @a cd_mag_inferno 0
scoreboard players set @a cd_adm_artillery 0
scoreboard players set @a cd_adm_torpedo 0
scoreboard players set @a cd_adm_air 0
scoreboard players set @a cd_adm_aa 0
scoreboard players set @a cd_formation 0
scoreboard players set @a cd_chrono_reverse 0
scoreboard players set @a cd_chrono_stasis 0
scoreboard players set @a cd_chrono_clockup 0
scoreboard players set @a cd_sculptor_create 0
scoreboard players set @a cd_stalker_float 0
scoreboard players set @a cd_super_jump 0
scoreboard players set @a cd_sam_zanshin 0
scoreboard players set @a cd_sam_iai 0
scoreboard players set @a cd_sam_hien 0
# 【追加】 役職別 上昇スキルCT
scoreboard players set @a cd_adm_jump 0
scoreboard players set @a cd_chrono_jump 0
scoreboard players set @a cd_sculptor_pillar 0
scoreboard players set @a cd_gambler_jump 0
# 【追加】 彫刻家 石化光線CT
scoreboard players set @a cd_sculptor_beam 0
# 【追加】 狙撃手 残弾 (常時満タン = 弾無限)
scoreboard players set @a[tag=sharpshooter] sharp_ammo 10
# 【追加】 獣使い CT
scoreboard players set @a cd_beast_wolf 0
scoreboard players set @a cd_beast_roar 0
scoreboard players set @a cd_beast_unleash 0

# マナを最大に
scoreboard players set @a[tag=magician] mana 100


