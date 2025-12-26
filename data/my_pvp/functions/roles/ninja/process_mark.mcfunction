# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 接地待ち (着地するまでは何もしない)
execute unless entity @s[nbt={OnGround:1b}] run return 0

# --- 以下、着地後の処理 ---

# 3. 所有者(プレイヤー)を特定
tag @a remove current_caster
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 4. アイテムを即座に補充
execute if entity @p[tag=current_caster,distance=..300] run give @p[tag=current_caster] minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# 5. CTチェックと実行
tag @s remove can_process
execute if entity @p[tag=current_caster,distance=..300] run tag @s add can_process

# A. CT中 (戻した上でエラー音)
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_ninja_mark=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.5

# B. OK (CTなし) -> 発動
# CT設定
execute if entity @s[tag=can_process] as @p[tag=current_caster,scores={cd_ninja_mark=0}] run scoreboard players set @s cd_ninja_mark 60

# 発動ロジック
# 【重要修正】as @p をやめ、if entity @p で条件チェックだけ行う
# これにより @s (アイテム) が維持され、プレイヤーが死ぬバグが直ります
execute if entity @s[tag=can_process] if entity @p[tag=current_caster,scores={cd_ninja_mark=60}] at @e[tag=can_process,limit=1] run function my_pvp:roles/ninja/trigger_mark_success

# 6. アイテム消去
kill @s