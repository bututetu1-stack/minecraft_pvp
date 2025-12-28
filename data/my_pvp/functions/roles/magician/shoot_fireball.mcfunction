# 炎玉発射処理

# 1. マナ消費
scoreboard players remove @s mana 5

# 2. 炎玉をスポーン（プレイヤーの視線方向に発射）
# 小さいファイアボールを使用（爆発なし、ダメージのみ）
summon small_fireball ^ ^ ^1.5 {Tags:["mag_fireball"]}

# 3. 発射した炎玉に所有者IDを記録
scoreboard players operation @e[type=small_fireball,tag=mag_fireball,limit=1,sort=nearest] player_id = @s player_id

# 4. 炎玉に寿命カウンター初期化
scoreboard players set @e[type=small_fireball,tag=mag_fireball,limit=1,sort=nearest] gadget_life 0

# 5. エフェクト
playsound minecraft:entity.blaze.shoot master @s ~ ~ ~ 1 1.2
particle minecraft:flame ^ ^ ^1 0.2 0.2 0.2 0.05 10

# 6. クールダウン設定 (1秒 = 20tick)
scoreboard players set @s cd_mag_book 20

# 7. アイテムを一時的に消す
clear @s minecraft:book{magician_book:1b} 1
