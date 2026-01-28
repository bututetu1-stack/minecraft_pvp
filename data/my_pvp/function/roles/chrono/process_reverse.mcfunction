# 1. 持ち主の特定
tag @s add processing_item
execute as @p[distance=..3,tag=chrono] run tag @s add skill_user

# 2. CTチェック (cd_chrono_reverse)
execute as @a[tag=skill_user] if score @s cd_chrono_reverse matches 1.. run tag @s add ct_error
execute as @a[tag=skill_user] unless score @s cd_chrono_reverse matches 1.. run function my_pvp:roles/chrono/use_reverse

# 3. エラー表示 (CT中の場合)
execute as @a[tag=skill_user,tag=ct_error] run title @s actionbar {"text":"Reverse Not Ready!","color":"red"}
execute as @a[tag=skill_user,tag=ct_error] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

# 4. アイテム返却 (Lore更新: 5秒前)
kill @e[tag=processing_item]
item replace entity @a[tag=skill_user] hotbar.1 with minecraft:light_blue_dye[minecraft:custom_data={chrono_reverse:1b},minecraft:custom_name='{"text":"<< タイム・リバース","color":"aqua","italic":false}',minecraft:lore=['{"text":"[Qキー] 5秒前の位置とHPに戻る","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}']]

# 5. タグ掃除
tag @a remove skill_user
tag @a remove ct_error