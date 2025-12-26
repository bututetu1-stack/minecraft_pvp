# 近くに落ちている自分の杖を探す
# 壱
execute as @e[type=item,distance=..3,nbt={Item:{tag:{Tags:["swap_1"]}}}] run give @p[tag=ninja,distance=..3] minecraft:carrot_on_a_stick{CustomModelData:1,display:{Name:'{"text":"変わり身：壱","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[1]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_1"]} 1

# 弐
execute as @e[type=item,distance=..3,nbt={Item:{tag:{Tags:["swap_2"]}}}] run give @p[tag=ninja,distance=..3] minecraft:carrot_on_a_stick{CustomModelData:2,display:{Name:'{"text":"変わり身：弐","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[2]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_2"]} 1

# 参
execute as @e[type=item,distance=..3,nbt={Item:{tag:{Tags:["swap_3"]}}}] run give @p[tag=ninja,distance=..3] minecraft:carrot_on_a_stick{CustomModelData:3,display:{Name:'{"text":"変わり身：参","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[3]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_3"]} 1

# 全ての杖アイテムを消去
kill @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}},distance=..3]