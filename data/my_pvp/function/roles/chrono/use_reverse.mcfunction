# 1. 5秒前のマーカーを探す (自分のIDを持つもの限定)
scoreboard players operation #ID temp = @s player_id
tag @s add reverse_user

# 距離制限内にあり、かつ「自分のID」を持つマーカーを検索
execute at @s as @e[tag=chrono_5s,distance=..60,limit=1,sort=nearest] if score @s player_id = #ID temp run tag @s add my_past_point

# 2. マーカーが見つからない場合 (エラー処理)
# 見つからなかったらエラーメッセージを出して、return 0 で処理をここで打ち切る
# これにより、下のCTセット処理が実行されなくなる
execute unless entity @e[tag=my_past_point] run tellraw @s {"text":"Error: 戻れる過去がありません","color":"red"}
execute unless entity @e[tag=my_past_point] run tag @s remove reverse_user
execute unless entity @e[tag=my_past_point] run return 0

# =================================================
# ▼▼▼ 以下、成功時の処理 ▼▼▼
# =================================================

# 3. CTセット (20秒 = 400tick)
# 成功が確定してからセットする
scoreboard players set @s cd_chrono_reverse 400

# 4. マーカーから HP & CT を回収 (kill する前に temp に保存)
scoreboard players operation #PAST_HP temp = @e[tag=my_past_point,limit=1] hp_snapshot
scoreboard players operation #PAST_STASIS temp = @e[tag=my_past_point,limit=1] cd_chrono_stasis
scoreboard players operation #PAST_CLOCKUP temp = @e[tag=my_past_point,limit=1] cd_chrono_clockup
scoreboard players operation #PAST_JUMP temp = @e[tag=my_past_point,limit=1] cd_chrono_jump

# 5. 移動処理
execute as @e[tag=my_past_point] run tp @a[tag=reverse_user] @s
kill @e[tag=my_past_point]

# 6. HP復元 (5秒前のHPに戻す / 記録が無い場合は HP を変更しない)
execute store result storage my_pvp:macro reverse.hp int 1 run scoreboard players get #PAST_HP temp
execute if score #PAST_HP temp matches 1.. run function my_pvp:roles/chrono/restore_hp with storage my_pvp:macro reverse

# 6b. CT復元 (5秒前のCT状態に戻す: 巻き戻しでCTが進んだり戻ったりする)
scoreboard players operation @s cd_chrono_stasis = #PAST_STASIS temp
scoreboard players operation @s cd_chrono_clockup = #PAST_CLOCKUP temp
scoreboard players operation @s cd_chrono_jump = #PAST_JUMP temp

# 6c. CTが0なのにアイテム不所持時の即時補充 (5秒前にすでにCT0だった場合)
execute unless score @s cd_chrono_stasis matches 1.. unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{chrono_stasis:1b}}}]}] run item replace entity @s container.2 with minecraft:yellow_dye[minecraft:custom_data={chrono_stasis:1b},minecraft:custom_name='{"text":"|| 時空の静止","color":"yellow","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、敵と物体を停止させる","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1
execute unless score @s cd_chrono_clockup matches 1.. unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{chrono_clockup:1b}}}]}] run item replace entity @s container.3 with minecraft:red_dye[minecraft:custom_data={chrono_clockup:1b},minecraft:custom_name='{"text":">> クロック・アップ","color":"red","italic":false}',minecraft:lore=['{"text":"[Qキー] 10秒間、超高速移動","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']] 1

# 7. 演出
playsound minecraft:item.chorus_fruit.teleport master @a ~ ~ ~ 1 0.5
playsound minecraft:block.beacon.activate master @a ~ ~ ~ 0.7 1.5
particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.5 0.5 0.1 50 force
particle minecraft:enchant ~ ~1.5 ~ 0.5 0.5 0.5 1 25 force
tellraw @s [{"text":"<< Time Reverse (5s)","color":"aqua","bold":true}]

# 8. タグ掃除
tag @s remove reverse_user