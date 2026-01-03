# 1. 持ち主の特定
tag @s add processing_item
execute as @p[distance=..3,tag=chrono] run tag @s add skill_user

# 2. CTチェック (cd_chrono_clockup)
execute as @a[tag=skill_user] if score @s cd_chrono_clockup matches 1.. run tag @s add ct_error
execute as @a[tag=skill_user] unless score @s cd_chrono_clockup matches 1.. run function my_pvp:roles/chrono/use_clockup

# 3. エラー表示 (CT中の場合)
execute as @a[tag=skill_user,tag=ct_error] run title @s actionbar {"text":"ClockUp Not Ready!","color":"red"}
execute as @a[tag=skill_user,tag=ct_error] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

# 4. アイテム返却 (Lore更新: 10秒間)
kill @e[tag=processing_item]
give @a[tag=skill_user] minecraft:red_dye{chrono_clockup:1b,display:{Name:'{"text":">> クロック・アップ","color":"red","italic":false}',Lore:['{"text":"[Qキー] 10秒間、超高速移動","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']}} 1

# 5. タグ掃除
tag @a remove skill_user
tag @a remove ct_error