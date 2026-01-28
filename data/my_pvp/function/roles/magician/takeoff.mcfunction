# 離陸処理 (Levitationによる飛行開始)

# 1. マナ消費
scoreboard players remove @s mana 5

# 2. 飛行タグ付与
tag @s add mag_flying_true

# 3. 飛行タイマー初期化
scoreboard players set @s mag_fly_tick 0

# 4. 初期上昇（離陸時は少し強めのLevitation）
effect give @s minecraft:levitation 1 3 true

# 5. エフェクト
playsound minecraft:entity.ender_dragon.flap master @s ~ ~ ~ 1 1.5
particle minecraft:end_rod ~ ~ ~ 0.5 0.5 0.5 0.1 20
particle minecraft:witch ~ ~ ~ 1 0.5 1 0.05 30

# 6. クールダウン設定 (1秒 = 20tick)
# CTを0に変更: 即時再使用可能にする
scoreboard players set @s cd_mag_broom 0

# 7. 通知
tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"離陸！","color":"aqua"}]
tellraw @s [{"text":"  ","color":"gray"},{"text":"[操作] ","color":"yellow"},{"text":"通常:上昇 / Q:着陸","color":"white"}]
