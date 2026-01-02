# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (持っていない場合のみ)
# 修正: Loreの "CT: 5s" を "CT: なし" に変更、または行ごと削除
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{Tags:["scout_bow"]}}]}] run give @s minecraft:bow{display:{Name:'{"text":"ワイヤーボウ","color":"aqua","bold":true}',Lore:['{"text":"着弾地点まで高速移動","color":"gray"}','{"text":"Sneak: 移動キャンセル","color":"yellow"}','{"text":"CT: なし","color":"aqua"}']},Unbreakable:1b,Enchantments:[{id:"minecraft:infinity",lvl:1s}],Tags:["scout_bow"]} 1

# 4. アイテム消去
kill @s