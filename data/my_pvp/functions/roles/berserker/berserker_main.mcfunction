# 1. UI表示 (Jump -> Rage の順に変更)
title @s actionbar [{"text":"Jump: ","color":"green"},{"score":{"name":"@s","objective":"cd_ber_jump"},"color":"white"},{"text":" | Rage: ","color":"dark_red"},{"score":{"name":"@s","objective":"cd_ber_raid"},"color":"white"}]

# 2. クールダウン消化 & アイテム返却

# ブラッドクリスタル
execute as @s[scores={cd_ber_raid=1}] run item replace entity @s container.2 with minecraft:red_dye{berserker_raid:1b,display:{Name:'{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',Lore:['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']}} 1
execute as @s[scores={cd_ber_raid=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 0.5
scoreboard players remove @s[scores={cd_ber_raid=1..}] cd_ber_raid 1

# リープフェザー
execute as @s[scores={cd_ber_jump=1}] run item replace entity @s container.1 with minecraft:feather{berserker_jump:1b,display:{Name:'{"text":"リープフェザー","color":"green","bold":true}',Lore:['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"(Cost: 4HP)","color":"gray"}','{"text":"着地時に衝撃波","color":"red"}','{"text":"CT: 8s","color":"aqua"}']}} 1
execute as @s[scores={cd_ber_jump=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_ber_jump=1..}] cd_ber_jump 1

# --- 3. 低HP時の常時強化 ---
execute store result score #HP temp run data get entity @s Health
execute if score #HP temp matches ..10 run effect give @s minecraft:strength 1 0 true
execute if score #HP temp matches ..10 run effect give @s minecraft:resistance 1 0 true

# --- 4. キル時回復 ---
execute unless score @s last_kills = @s kills run effect give @s minecraft:instant_health 1 3 true
execute unless score @s last_kills = @s kills run playsound minecraft:entity.player.levelup master @s ~ ~ ~ 1 2
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# --- 5. ジャンプ・着地監視 ---
execute if entity @s[tag=ber_ready] run function my_pvp:roles/berserker/check_slam
execute if entity @s[tag=ber_falling] run function my_pvp:roles/berserker/check_slam