# Unconditional Verification

# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者チェック (近くのBerserker)
execute if entity @p[tag=berserker,distance=..6] run tag @s add can_process
tag @a remove on_cd
tag @a remove is_ready

# 3. 状態チェック & 振り分け
# Debug: Found candidate?

# Check Score and Tag Player directly
execute if entity @s[tag=can_process] as @p[tag=berserker,distance=..6,sort=nearest,limit=1] unless score @s cd_ber_raid matches 1.. run tag @s add is_ready
execute if entity @s[tag=can_process] as @p[tag=berserker,distance=..6,sort=nearest,limit=1] if score @s cd_ber_raid matches 1.. run tag @s add on_cd

# Debug: Check if tags were applied

# 4. 実行 (Ready)
# CT設定 (15秒 = 300tick) -> 実行したプレイヤー(@p[tag=is_ready])に設定
execute if entity @s[tag=can_process] as @p[tag=is_ready,limit=1] run scoreboard players set @s cd_ber_raid 300
execute if entity @s[tag=can_process] as @p[tag=is_ready,limit=1,tag=rush_mode] run item replace entity @s container.2 with minecraft:red_dye[custom_data={berserker_raid:1b},custom_name='{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',lore=['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']] 1

# バフの発動処理
# コスト: 10ダメージ
execute unless score #GLOBAL event_type matches 5 as @p[tag=is_ready] run damage @s 10 minecraft:magic

# 効果
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:strength 10 1 true
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:speed 10 1 true
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:darkness 10 0 true

# 演出
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run playsound minecraft:entity.warden.heartbeat master @a ~ ~ ~ 1 1
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run playsound minecraft:entity.ravager.roar master @a ~ ~ ~ 1 1

# 血飛沫
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run particle dust{color:[0.8,0.0,0.0],scale:1.0} ~ ~1 ~ 0.5 0.5 0.5 0.1 50
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run particle item{item:"minecraft:red_dye"} ~ ~1.5 ~ 0.3 0.5 0.3 0.1 20

# 5. 失敗時の返却処理 (On CD)
execute if entity @s[tag=can_process] as @p[tag=on_cd] at @s run function my_pvp:roles/berserker/cd_error
execute if entity @s[tag=can_process] as @p[tag=on_cd] at @s run give @s minecraft:red_dye[minecraft:custom_data={berserker_raid:1b},minecraft:custom_name='{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']] 1

# Debug info if logic fails (visible only if no tags set?)
# execute if entity @s[tag=can_process] unless entity @p[tag=is_ready] unless entity @p[tag=on_cd] run tellraw @a {"text":"[Debug] Error: No Player Logic Matched","color":"red"}

# アイテム消去
execute if entity @s[tag=can_process] run kill @s