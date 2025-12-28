# 1. アイテム保護 & 所有者特定
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=berserker] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 2. 条件チェック (CTのみ)
tag @s remove can_process
execute if entity @p[tag=current_caster,scores={cd_ber_jump=0}] run tag @s add can_process

# --- 3. 発動 (成功時) ---
# CT設定 (8秒)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run scoreboard players set @s cd_ber_jump 160

# ジャンプ処理 (Levitationで打ち上げ)
# Level 20 * 5tick = 瞬間的な大ジャンプ
execute if entity @s[tag=can_process] as @p[tag=current_caster] run effect give @s minecraft:levitation 1 20 true

# 演出
execute if entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:entity.bat.takeoff master @a ~ ~ ~ 1 0.8
execute if entity @s[tag=can_process] at @p[tag=current_caster] run particle minecraft:cloud ~ ~ ~ 0.5 0 0.5 0.1 10

# --- 4. 失敗時 ---
execute unless entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

# 5. アイテム返却 & 消去
execute as @p[tag=current_caster] unless entity @s[nbt={Inventory:[{tag:{berserker_jump:1b}}]}] run give @s minecraft:feather{berserker_jump:1b,display:{Name:'{"text":"リープフェザー","color":"green","bold":true}',Lore:['{"text":"Q: 大ジャンプ","color":"gray"}','{"text":"CT: 8s","color":"aqua"}']}} 1
kill @s