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
execute as @a run attribute @s minecraft:generic.max_health base set 20
execute as @a run attribute @s minecraft:generic.knockback_resistance base set 0
# バーサーカー用リセット
scoreboard players reset * cd_ber_raid
scoreboard players reset * cd_ber_jump

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
tag @a remove target_candidate

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

tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

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

# 残留アイテムの完全消去
kill @e[type=item]

# タイマーリセット
scoreboard players set #GLOBAL match_timer 0
scoreboard players set #GLOBAL match_state 0