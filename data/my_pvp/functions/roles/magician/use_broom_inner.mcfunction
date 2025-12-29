# 実際の使用処理（シンプル化）
# アイテム使用はタグの付け外しのみを行う。

# 飛行中なら着陸処理を呼ぶ（着地処理は `land` にて効果解除などを行う）
execute if entity @s[tag=mag_flying] run function my_pvp:roles/magician/land

# 飛行していない場合はマナをチェックして離陸（不足なら通知）
execute unless entity @s[tag=mag_flying] if score @s mana matches ..4 run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"マナが足りません！","color":"red"}]
execute unless entity @s[tag=mag_flying] if score @s mana matches ..4 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# マナがあれば既存の離陸処理を呼ぶ（`takeoff` がマナ消費とエフェクトを担当）
execute unless entity @s[tag=mag_flying] if score @s mana matches 5.. run function my_pvp:roles/magician/takeoff
