# 1. アイテム保護 & 所有者特定
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=berserker] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 2. 条件チェック
tag @s remove can_process
execute if entity @p[tag=current_caster,scores={cd_ber_jump=0}] run tag @s add can_process

# --- 3. 発動 (成功時) ---
# CT設定
execute if entity @s[tag=can_process] as @p[tag=current_caster] run scoreboard players set @s cd_ber_jump 160

# 自傷ダメージ (4ダメージ)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run damage @s 4 minecraft:generic

# ジャンプ処理 (Levitation 20)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run effect give @s minecraft:levitation 1 20 true

# 【変更】発射準備タグを付与 (ber_leaping ではなく ber_ready)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run tag @s add ber_ready

# 演出
execute if entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:entity.bat.takeoff master @a ~ ~ ~ 1 0.6
execute if entity @s[tag=can_process] at @p[tag=current_caster] run particle minecraft:cloud ~ ~ ~ 0.5 0 0.5 0.1 20

# --- 4. 失敗時 ---
execute unless entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

# 5. アイテム返却 (失敗時のみ) & 消去
execute unless entity @s[tag=can_process] as @p[tag=current_caster] unless entity @s[nbt={Inventory:[{tag:{berserker_jump:1b}}]}] run give @s minecraft:feather{berserker_jump:1b,display:{Name:'{"text":"リープフェザー","color":"green","bold":true}',Lore:['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"(Cost: 4HP)","color":"gray"}','{"text":"着地時に衝撃波","color":"red"}','{"text":"CT: 8s","color":"aqua"}']}} 1

kill @s