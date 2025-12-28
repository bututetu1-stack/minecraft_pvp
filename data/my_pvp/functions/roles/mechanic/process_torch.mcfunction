# 1. アイテム保護と接地待ち
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0

# 2. 所有者(プレイヤー)を特定
tag @a remove current_caster
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=mechanic] if score @s player_id = #TEMP player_id run tag @s add current_caster

# --- 3. 所有者が近くにいるかチェック ---
execute if entity @p[tag=current_caster,distance=..300] run tag @s add can_process

# --- 4. 状態チェックとタグ付け ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# A. CT中
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=1..}] run tag @s add on_cd
# B. OK (コスト8以上)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=0,scrap=8..}] run tag @s add is_ready
# C. 金欠 (コスト7以下)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_turret=0,scrap=..7}] run tag @s add no_money


# --- 5. 実行処理 ---
# 成功時：CD設定(100tick) -> 召喚関数実行
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_turret 100
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_sentry

# 失敗時：エラー表示
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# アイテム消去
execute if entity @s[tag=can_process] run kill @s