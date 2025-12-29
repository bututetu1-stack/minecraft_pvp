# 実際の使用処理（シンプル化）
# アイテム使用はタグの付け外しのみを行う。

# シンプルなトグル動作
# 飛行中なら着陸、そうでなければマナを消費して飛行開始（タグ付与）
execute if entity @s[tag=mag_flying] unless entity @s[tag=mag_action_lock] run function my_pvp:roles/magician/land

execute unless entity @s[tag=mag_flying] if score @s mana matches ..4 run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"マナが足りません！","color":"red"}]
execute unless entity @s[tag=mag_flying] if score @s mana matches ..4 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

execute unless entity @s[tag=mag_flying] if score @s mana matches 5.. run scoreboard players remove @s mana 5
execute unless entity @s[tag=mag_flying] if score @s mana matches 5.. run tag @s add mag_flying
execute unless entity @s[tag=mag_flying] if score @s mana matches 5.. run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"浮遊！","color":"aqua"}]
execute unless entity @s[tag=mag_flying] if score @s mana matches 5.. run playsound minecraft:entity.ender_dragon.flap master @s ~ ~ ~ 1 1.2
execute unless entity @s[tag=mag_flying] if score @s mana matches 5.. run particle minecraft:end_rod ~ ~ ~ 0.3 0.3 0.3 0.05 10
