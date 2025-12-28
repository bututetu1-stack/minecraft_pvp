# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 生成判定 (OnGround または 停止時)
tag @s remove can_spawn
execute if entity @s[nbt={OnGround:1b}] run tag @s add can_spawn
execute if entity @s[nbt={Motion:[0.0,0.0,0.0]}] run tag @s add can_spawn
execute unless entity @s[tag=can_spawn] run return 0

# 3. 所有者特定
tag @a remove current_caster
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=mechanic] if score @s player_id = #TEMP player_id run tag @s add current_caster

# --- 4. 所有者が近くにいるかチェック ---
tag @s remove can_process
execute if entity @p[tag=current_caster,distance=..300] run tag @s add can_process

# --- 5. 状態チェックとタグ付け ---
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# A. CT中
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=1..}] run tag @s add on_cd
# B. OK (コスト6以上)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=0,scrap=6..}] run tag @s add is_ready
# C. 金欠 (コスト5以下)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_launcher=0,scrap=..5}] run tag @s add no_money


# --- 6. 実行処理 ---
# 成功時：召喚関数実行
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_launcher

# 失敗時：エラー表示
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# アイテム消去
execute if entity @s[tag=can_process] run kill @s