# 1. UI表示 (Jump -> Rage の順に変更)
title @s actionbar [{"text":"Jump: ","color":"green"},{"score":{"name":"@s","objective":"cd_ber_jump"},"color":"white"},{"text":" | Rage: ","color":"dark_red"},{"score":{"name":"@s","objective":"cd_ber_raid"},"color":"white"}]

# 2. クールダウン消化 & アイテム返却

# ブラッドクリスタル
# ブラッドクリスタル
execute as @s[scores={cd_ber_raid=1}] run item replace entity @s container.2 with minecraft:red_dye[custom_data={berserker_raid:1b},custom_name='{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',lore=['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']] 1
execute as @s[scores={cd_ber_raid=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 0.5
scoreboard players remove @s[scores={cd_ber_raid=1..}] cd_ber_raid 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_ber_raid=0}] unless entity @s[nbt={Inventory:[{Slot:2b,id:"minecraft:red_dye"}]}] run item replace entity @s container.2 with minecraft:red_dye[custom_data={berserker_raid:1b},custom_name='{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',lore=['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']] 1

# リープフェザー
execute as @s[scores={cd_ber_jump=1}] run item replace entity @s container.1 with minecraft:feather[custom_data={berserker_jump:1b},custom_name='{"text":"リープフェザー","color":"green","bold":true}',lore=['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"(Cost: 4HP)","color":"gray"}','{"text":"着地時に衝撃波","color":"red"}','{"text":"空中[Shift]: 急降下 (衝撃波強化)","color":"red"}','{"text":"CT: 8s","color":"aqua"}']] 1
execute as @s[scores={cd_ber_jump=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_ber_jump=1..}] cd_ber_jump 1
# Rush Mode Safety
execute as @s[tag=rush_mode,scores={cd_ber_jump=0}] unless entity @s[nbt={Inventory:[{Slot:1b,id:"minecraft:feather"}]}] run item replace entity @s container.1 with minecraft:feather[custom_data={berserker_jump:1b},custom_name='{"text":"リープ・フェザー","color":"green","bold":true}',lore=['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"(Cost: 4HP)","color":"gray"}','{"text":"着地時に衝撃波","color":"red"}','{"text":"空中[Shift]: 急降下 (衝撃波強化)","color":"red"}','{"text":"CT: 8s","color":"aqua"}']] 1

# --- 3. 低HP時の常時強化 ---
execute store result score #HP temp run data get entity @s Health
execute if score #HP temp matches ..10 run effect give @s minecraft:strength 1 0 true
execute if score #HP temp matches ..10 run effect give @s minecraft:resistance 1 0 true

# --- 4. キル時回復 ---
execute unless score @s last_kills = @s kills run effect give @s minecraft:instant_health 1 3 true
execute unless score @s last_kills = @s kills run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 2
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# --- 5. ジャンプ・着地監視 ---
# 急降下: リープ中 (ber_falling) に空中で Shift → 一気に落下し、着地の衝撃波を強化する
execute if entity @s[tag=ber_falling,tag=!ber_slamming] if score @s sneak_time matches 1.. run function my_pvp:roles/berserker/start_dive
execute if entity @s[tag=ber_slamming] at @s run function my_pvp:roles/berserker/dive_tick
execute if entity @s[tag=ber_ready] run function my_pvp:roles/berserker/check_slam
execute if entity @s[tag=ber_falling] run function my_pvp:roles/berserker/check_slam

# 共通スキル (大ジャンプ)
# リープ中の Shift は急降下に使うので、大ジャンプは発動させない
execute if entity @s[tag=ber_falling] run scoreboard players set @s sneak_time 0
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump