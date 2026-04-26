# スコープ: 投げ禁止 → 即時返却 (主武器のため)
data merge entity @s {PickupDelay:0s}

# 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sharpshooter] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# アイテム返却 (slot 0 主武器)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sharpshooter_focus:1b}}}]}] run item replace entity @s container.0 with minecraft:spyglass[minecraft:custom_data={sharpshooter_focus:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"集中スコープ","color":"aqua","bold":true,"italic":false}',minecraft:lore=['{"text":"右クリ保持: 集中状態 + 魔導弾連射","color":"yellow"}','{"text":"  狙い安定 (鈍足II)","color":"gray"}','{"text":"  半径15内の敵に発光","color":"gray"}','{"text":"  0.6秒ごとに視線方向に魔導弾発射 (damage 4)","color":"gray"}']] 1

tag @a remove item_recipient
kill @s
