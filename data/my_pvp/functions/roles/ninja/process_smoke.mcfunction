# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、着地後の処理 ---

# 3. 所有者特定
tag @a remove current_caster
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 4. アイテム補充
# 【削除】CT明けに配るため、ここでは返却しません
# (行ごと削除するか、コメントアウトしてください)

# 5. CTチェックと実行
tag @s remove can_process
execute if entity @p[tag=current_caster,distance=..300] run tag @s add can_process

# A. CT中 (ここに来ることは稀ですが、念のためエラー音だけ)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_ninja_smoke=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.5

# B. OK -> 発動
# CT設定 (15秒後に ninja_main で返却されます)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_ninja_smoke=0}] run scoreboard players set @s cd_ninja_smoke 300

# 発動ロジック
execute if entity @s[tag=can_process] if entity @p[tag=current_caster,scores={cd_ninja_smoke=300}] at @e[tag=can_process,limit=1] run function my_pvp:roles/ninja/trigger_smoke_logic

# 6. アイテム消去
kill @s