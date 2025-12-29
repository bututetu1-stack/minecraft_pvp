# 着陸処理

# 1. 飛行タグ解除
tag @s remove mag_flying

# 2. 飛行エフェクトを全て解除
effect clear @s minecraft:levitation

# 4. エフェクト
playsound minecraft:entity.phantom.flap master @s ~ ~ ~ 1 0.8
particle minecraft:cloud ~ ~ ~ 0.5 0.1 0.5 0.1 15
particle minecraft:witch ~ ~ ~ 0.8 0.3 0.8 0.02 20

# 5. 通知
tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"着地！","color":"yellow"}]

# 5.5. 飛行終了時のアイテム返却（所持していなければ戻す）
execute unless entity @s[nbt={Inventory:[{tag:{magician_broom:1b}}]}] run give @s minecraft:stick{magician_broom:1b,display:{Name:'{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',Lore:['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"飛行中: 通常=上昇 / Shift=下降","color":"white"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 0s","color":"aqua"}']}} 1

# 6. クールダウン設定 (1秒 = 20tick)
scoreboard players set @s cd_mag_broom 0
