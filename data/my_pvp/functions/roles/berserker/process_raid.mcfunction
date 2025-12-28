# 1. アイテム保護 & 所有者特定
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=berserker] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 2. 条件チェック
tag @s remove can_process
# CTチェック
execute if entity @p[tag=current_caster,scores={cd_ber_raid=0}] run tag @s add can_process
# HPコストチェック (現在HPが10以下なら発動不可)
execute as @p[tag=current_caster] store result score #HP temp run data get entity @s Health
execute if score #HP temp matches ..10 run tag @s remove can_process

# --- 3. 発動 (成功時) ---
# CT設定 (15秒)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run scoreboard players set @s cd_ber_raid 300

# コスト支払い (10ダメージ)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run damage @s 10 minecraft:generic

# 自己バフ付与 (10秒間)
# 攻撃力上昇 I (Lv1), 移動速度上昇 II (Lv2)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run effect give @s minecraft:strength 10 0 true
execute if entity @s[tag=can_process] as @p[tag=current_caster] run effect give @s minecraft:speed 10 1 true

# 【修正】暗闇 (Darkness) を付与
execute if entity @s[tag=can_process] as @p[tag=current_caster] run effect give @s minecraft:darkness 10 0 true

# 演出
execute if entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:entity.zombie_villager.cure master @a ~ ~ ~ 1 0.5
execute if entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:entity.wither.shoot master @a ~ ~ ~ 0.5 0.5
execute if entity @s[tag=can_process] at @p[tag=current_caster] run particle minecraft:dust 1.0 0.0 0.0 2.0 ~ ~1 ~ 0.5 0.5 0.5 0.1 50
execute if entity @s[tag=can_process] at @p[tag=current_caster] run particle minecraft:soul_fire_flame ~ ~1 ~ 0.3 0.5 0.3 0.05 20

# UI表示
execute if entity @s[tag=can_process] as @p[tag=current_caster] run title @s actionbar [{"text":"BLOOD RAGE ACTIVE!","color":"dark_red","bold":true}]

# --- 4. 失敗時 ---
execute unless entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2
execute unless entity @s[tag=can_process] at @p[tag=current_caster] run tellraw @s [{"text":"⚠ HP不足 または CT中","color":"red"}]

# 5. アイテム返却 (失敗時のみ) & 消去
# 成功時はCT管理(berserker_main)で返却されるため、ここでは返さない
execute unless entity @s[tag=can_process] as @p[tag=current_caster] unless entity @s[nbt={Inventory:[{tag:{berserker_raid:1b}}]}] run item replace entity @s container.2 with minecraft:red_dye{berserker_raid:1b,display:{Name:'{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',Lore:['{"text":"Q: ブラッドレイジ (Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']}} 1

kill @s