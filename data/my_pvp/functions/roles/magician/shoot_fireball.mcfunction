# 炎玉発射処理

# 1. マナ消費
scoreboard players remove @s mana 5

# 2. 炎玉をプレイヤー基準でスポーン（視線方向に発射）
# armor_stand 弾として召喚する（移動は fireball_tick が担当）
# 召喚位置を目線（+1.62）にし、プレイヤーの向きをコピーして正しく前方へ進ませる
execute as @s at @s run summon armor_stand ^ ^1.62 ^0.7 {Tags:["mag_fireball","gadget"],NoGravity:1b,Marker:1b,Invisible:1b,Invulnerable:1b}
execute as @s at @s run data modify entity @e[type=armor_stand,tag=mag_fireball,limit=1,sort=nearest] Rotation set from entity @s Rotation

# 3. 発射した炎玉に所有者IDを記録（プレイヤー基準で nearest を取得）

execute as @s at @s run scoreboard players operation @e[type=armor_stand,tag=mag_fireball,limit=1,sort=nearest] player_id = @s player_id

# 4. 炎玉に寿命カウンター初期化

execute as @s at @s run scoreboard players set @e[type=armor_stand,tag=mag_fireball,limit=1,sort=nearest] gadget_life 0

# 5. エフェクト（プレイヤーの位置で再生）
execute as @s at @s run playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 1 1.2
execute as @s at @s run particle minecraft:flame ^ ^ ^1 0.2 0.2 0.2 0.05 10

# 6. クールダウン設定
# クールダウンを0に設定（即時再使用可能）
scoreboard players set @s cd_mag_book 0

# 7. アイテムを一時的に消す
clear @s minecraft:book{magician_book:1b} 1
