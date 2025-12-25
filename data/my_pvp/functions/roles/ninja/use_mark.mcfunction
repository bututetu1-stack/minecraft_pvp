# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 地面に着くまで待機
execute unless entity @s[nbt={OnGround:1b}] run return 0

# 3. 持ち主特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add current_caster

# --- 【重要】アイテム即時補充 ---
# 発動の成否に関わらず、まずはアイテムを返して「手元にある状態」にします
execute as @a[tag=current_caster] run give @s minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1


# 4. CTチェックと発動
# CT中ならエラー音
execute as @a[tag=current_caster,scores={cd_ninja_mark=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.5

# CTが0なら発動
execute as @a[tag=current_caster,scores={cd_ninja_mark=0}] run function my_pvp:roles/ninja/trigger_mark_success

# 5. 後始末 (補充済みなので本体は消す)
kill @s