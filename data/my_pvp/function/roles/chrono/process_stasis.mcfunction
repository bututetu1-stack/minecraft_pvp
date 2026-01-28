# 1. 持ち主の特定
tag @s add processing_item
execute as @p[distance=..3,tag=chrono] run tag @s add skill_user

# 2. CTチェック (cd_chrono_stasis)
execute as @a[tag=skill_user] if score @s cd_chrono_stasis matches 1.. run tag @s add ct_error
execute as @a[tag=skill_user] unless score @s cd_chrono_stasis matches 1.. run function my_pvp:roles/chrono/use_stasis

# 3. エラー表示 (CT中の場合)
execute as @a[tag=skill_user,tag=ct_error] run title @s actionbar {"text":"Stasis Not Ready!","color":"red"}
execute as @a[tag=skill_user,tag=ct_error] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

# 4. アイテム返却 (Lore更新: 10秒間)
kill @e[tag=processing_item]
give @a[tag=skill_user] minecraft:yellow_dye[minecraft:custom_data={chrono_stasis:1b},minecraft:custom_name='{"text":"|| 時空の静止","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1

# 5. タグ掃除
tag @a remove skill_user
tag @a remove ct_error