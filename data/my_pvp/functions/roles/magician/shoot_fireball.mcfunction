# 炎玉発射処理

# 1. マナ消費
scoreboard players remove @s mana 5

# 2. 炎玉をプレイヤー基準でスポーン（視線方向に発射）
# summon をプレイヤーの位置と向きで実行するため、execute as/at を追加
execute as @s at @s run summon small_fireball ^ ^ ^1.5 {Tags:["mag_fireball"]}

# 3. 発射した炎玉に所有者IDを記録（プレイヤー基準で nearest を取得）
execute as @s at @s run scoreboard players operation @e[type=small_fireball,tag=mag_fireball,limit=1,sort=nearest] player_id = @s player_id

# 4. 炎玉に寿命カウンター初期化
execute as @s at @s run scoreboard players set @e[type=small_fireball,tag=mag_fireball,limit=1,sort=nearest] gadget_life 0

# 5. エフェクト（プレイヤーの位置で再生）
execute as @s at @s run playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 1 1.2
execute as @s at @s run particle minecraft:flame ^ ^ ^1 0.2 0.2 0.2 0.05 10

# 6. クールダウン設定 (1秒 = 20tick)
# クールダウン設定: 1秒に設定（CT: 1s）
scoreboard players set @s cd_mag_book 20

# 7. アイテムを一時的に消す
clear @s minecraft:book{magician_book:1b} 1
