# 魔術本の使用処理（炎玉発射）

# クールダウン中チェック
execute if score @s cd_mag_book matches 1.. run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"クールダウン中...","color":"gray"}]
execute if score @s cd_mag_book matches 1.. run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# マナチェック
execute if score @s cd_mag_book matches 0 if score @s mana matches ..4 run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"マナが足りません！","color":"red"}]
execute if score @s cd_mag_book matches 0 if score @s mana matches ..4 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# 発射実行
execute if score @s cd_mag_book matches 0 if score @s mana matches 5.. run function my_pvp:roles/magician/shoot_fireball
