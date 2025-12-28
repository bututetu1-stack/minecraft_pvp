# 着陸処理

# 1. 飛行タグ解除
tag @s remove mag_flying

# 2. 飛行エフェクトを全て解除
effect clear @s minecraft:slow_falling
effect clear @s minecraft:levitation

# 3. 落下ダメージ軽減（着陸直後のみ）
effect give @s minecraft:slow_falling 2 0 true

# 4. エフェクト
playsound minecraft:entity.phantom.flap master @s ~ ~ ~ 1 0.8
particle minecraft:cloud ~ ~ ~ 0.5 0.1 0.5 0.1 15
particle minecraft:witch ~ ~ ~ 0.8 0.3 0.8 0.02 20

# 5. 通知
tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"着陸！","color":"yellow"}]

# 6. クールダウン設定 (1秒 = 20tick)
scoreboard players set @s cd_mag_broom 20
