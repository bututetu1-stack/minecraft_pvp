# 居合: ドロップで発動
# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=samurai] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# CT中なら返却して何もしない
execute as @a[tag=item_recipient] if score @s cd_sam_iai matches 1.. run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={samurai_iai:1b},minecraft:custom_name='{"text":"居合 (CT中)","color":"gray"}',minecraft:lore=['{"text":"準備中...","color":"gray"}']] 1
execute if entity @a[tag=item_recipient,scores={cd_sam_iai=1..}] run kill @s
execute if entity @a[tag=item_recipient,scores={cd_sam_iai=1..}] run return 0

# CT明けなら発動
execute as @a[tag=item_recipient] at @s run function my_pvp:roles/samurai/use_iai

# アイテム消去
kill @s
