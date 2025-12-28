# 魔術箒の使用処理（飛行開始/終了トグル）

# --- クールダウン中チェック ---
execute if score @s cd_mag_broom matches 1.. run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"クールダウン中...","color":"gray"}]
execute if score @s cd_mag_broom matches 1.. run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# --- 飛行中の場合: 着陸 ---
execute if score @s cd_mag_broom matches 0 if entity @s[tag=mag_flying] run function my_pvp:roles/magician/land

# --- 飛行していない場合: 離陸 ---
# マナチェック
execute if score @s cd_mag_broom matches 0 unless entity @s[tag=mag_flying] if score @s mana matches ..4 run tellraw @s [{"text":"[Magician] ","color":"light_purple"},{"text":"マナが足りません！","color":"red"}]
execute if score @s cd_mag_broom matches 0 unless entity @s[tag=mag_flying] if score @s mana matches ..4 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5

# 離陸実行
execute if score @s cd_mag_broom matches 0 unless entity @s[tag=mag_flying] if score @s mana matches 5.. run function my_pvp:roles/magician/takeoff
