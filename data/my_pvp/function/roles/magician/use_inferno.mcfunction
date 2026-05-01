# 業火爆裂 発動 (@s = magician, at @s)

# CT中チェック
execute if score @s cd_mag_inferno matches 1.. run tellraw @s [{"text":"[Inferno] ","color":"red"},{"text":"クールダウン中...","color":"gray"}]
execute if score @s cd_mag_inferno matches 1.. run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute if score @s cd_mag_inferno matches 1.. run return 0

# MPチェック (25必要)
execute if score @s mana matches ..24 run tellraw @s [{"text":"[Inferno] ","color":"red"},{"text":"マナが足りません！ (25必要)","color":"red"}]
execute if score @s mana matches ..24 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute if score @s mana matches ..24 run return 0

# === 発動: コスト消費 + CT設定 ===
execute unless entity @s[tag=rush_mode] run scoreboard players remove @s mana 25
execute unless entity @s[tag=rush_mode] run scoreboard players set @s cd_mag_inferno 200

# === 投射体スポーン ===
function my_pvp:roles/magician/shoot_inferno
