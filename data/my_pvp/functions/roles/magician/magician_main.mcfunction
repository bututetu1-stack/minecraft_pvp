# 1. UI表示
title @s actionbar [{"text":"MANA: ","color":"light_purple"},{"score":{"name":"@s","objective":"mana"},"color":"white"}]

# 2. マナ自動回復 (1秒ごとに1増加) - ただし飛行中は回復しない
scoreboard players operation @s temp = #GLOBAL match_timer
scoreboard players operation @s temp %= #20 temp
execute if score @s temp matches 0 if score #GLOBAL match_timer matches 1.. unless entity @s[tag=mag_flying_true] run scoreboard players add @s mana 2

# マナ上限(100)
execute if score @s mana matches 101.. run scoreboard players set @s mana 100

# --- キル時のマナ回復 (+30) ---
execute unless score @s last_kills = @s kills run scoreboard players add @s mana 30
execute unless score @s last_kills = @s kills run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 2
execute unless score @s last_kills = @s kills run scoreboard players operation @s last_kills = @s kills

# 3. 飛行中のマナ消費 (タグ `mag_flying` がついている間、1秒ごとに5マナ消費)
#    シンプル化のため mag_fly_timer を使わず、20tickごとの判定は別途簡易化できます。
execute if entity @s[tag=mag_flying_true] run scoreboard players add @s mag_fly_tick 1
# 3a. 20tick到達時の処理: マナが5以上なら5消費、未満なら着陸させる（マイナス防止）
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches 5.. run scoreboard players remove @s mana 5
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches 5.. run scoreboard players set @s mag_fly_tick 0
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches ..4 run function my_pvp:roles/magician/land
execute if entity @s[tag=mag_flying_true] if score @s mag_fly_tick matches 20.. if score @s mana matches ..4 run scoreboard players set @s mag_fly_tick 0

# 3.5. 飛行中のエフェクト付与（シンプル化）
# タグ `mag_flying` がついている間だけ Levitation を付与する
execute as @s[tag=mag_flying_true] run effect give @s minecraft:levitation 2 4 true

# 4. マナ切れで強制着陸
execute if entity @s[tag=mag_flying_true] if score @s mana matches ..4 run function my_pvp:roles/magician/land

# 5. クールダウン消化 & アイテム返却

# 魔術箒 (Slot 0)
execute as @s[scores={cd_mag_broom=1}] run item replace entity @s container.0 with minecraft:stick{magician_broom:1b,display:{Name:'{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',Lore:['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}']}} 1
execute as @s[scores={cd_mag_broom=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_mag_broom=1..}] cd_mag_broom 1

# 魔術本 (Slot 1)
execute as @s[scores={cd_mag_book=1}] run item replace entity @s container.1 with minecraft:book{magician_book:1b,display:{Name:'{"text":"魔術本","italic":false,"color":"gold","bold":true}',Lore:['{"text":"[Q]キー: 炎玉発射","color":"yellow"}','{"text":"Cost: 5 MANA","color":"gray"}','{"text":"ダメージ: ハート3個分","color":"red"}','{"text":"CT: 0s","color":"aqua"}']}} 1
execute as @s[scores={cd_mag_book=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_mag_book=1..}] cd_mag_book 1
