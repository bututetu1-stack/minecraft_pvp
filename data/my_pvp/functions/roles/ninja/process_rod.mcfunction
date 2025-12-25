# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 持ち主特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=ninja] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. 該当する杖を配布 (落とした杖の種類を判定して返す)
# 壱
execute if entity @s[nbt={Item:{tag:{swap_1:1b}}}] as @a[tag=item_recipient] run give @s minecraft:carrot_on_a_stick{CustomModelData:1,display:{Name:'{"text":"変わり身：壱","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[1]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_1"]} 1
# 弐
execute if entity @s[nbt={Item:{tag:{swap_2:1b}}}] as @a[tag=item_recipient] run give @s minecraft:carrot_on_a_stick{CustomModelData:2,display:{Name:'{"text":"変わり身：弐","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[2]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_2"]} 1
# 参
execute if entity @s[nbt={Item:{tag:{swap_3:1b}}}] as @a[tag=item_recipient] run give @s minecraft:carrot_on_a_stick{CustomModelData:3,display:{Name:'{"text":"変わり身：参","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[3]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_3"]} 1

# 4. エンティティ消去
kill @s