# 実際の使用処理（シンプル化）
# アイテム使用はタグの付け外しのみを行う。

# シンプルなトグル動作
# 飛行中の判定: `mag_flying_true` があれば着陸
execute if entity @s[tag=mag_flying_true] run function my_pvp:roles/magician/land_from_use

# 飛行中でなければ離陸（`mag_use_handled` が付かれていれば land が実行済みなので離陸しない）
execute unless entity @s[tag=mag_flying_true] unless entity @s[tag=mag_use_handled] if score @s mana matches ..4 run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"マナが足りません！","color":"red"}]
execute unless entity @s[tag=mag_flying_true] unless entity @s[tag=mag_use_handled] if score @s mana matches ..4 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute unless entity @s[tag=mag_flying_true] unless entity @s[tag=mag_use_handled] if score @s mana matches 5.. run function my_pvp:roles/magician/takeoff

# 後片付け
tag @s remove mag_use_handled
