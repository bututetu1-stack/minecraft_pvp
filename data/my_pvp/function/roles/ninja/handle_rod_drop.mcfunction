# 近くに落ちている自分の杖を探す
# 壱
# 【修正】Loreの "CT: 15s" を "CT: 10s" に変更
execute as @e[type=item,distance=..3,nbt={Item:{components:{"minecraft:custom_data":{Tags:["swap_1"]}}}}] run give @p[tag=ninja,distance=..3] minecraft:carrot_on_a_stick[minecraft:custom_data={Tags:["ninja_tool","swap_1"]},minecraft:custom_model_data=1,minecraft:custom_name='{"text":"変わり身：壱","color":"yellow"}',minecraft:lore=['{"text":"右クリック: 身代わり[1]と入替","color":"gray"}','{"text":"CT: 10s (共通)","color":"aqua"}']] 1

# 弐
# 【修正】Loreの "CT: 15s" を "CT: 10s" に変更
execute as @e[type=item,distance=..3,nbt={Item:{components:{"minecraft:custom_data":{Tags:["swap_2"]}}}}] run give @p[tag=ninja,distance=..3] minecraft:carrot_on_a_stick[minecraft:custom_data={Tags:["ninja_tool","swap_2"]},minecraft:custom_model_data=2,minecraft:custom_name='{"text":"変わり身：弐","color":"yellow"}',minecraft:lore=['{"text":"右クリック: 身代わり[2]と入替","color":"gray"}','{"text":"CT: 10s (共通)","color":"aqua"}']] 1

# 参
# 【修正】Loreの "CT: 15s" を "CT: 10s" に変更
execute as @e[type=item,distance=..3,nbt={Item:{components:{"minecraft:custom_data":{Tags:["swap_3"]}}}}] run give @p[tag=ninja,distance=..3] minecraft:carrot_on_a_stick[minecraft:custom_data={Tags:["ninja_tool","swap_3"]},minecraft:custom_model_data=3,minecraft:custom_name='{"text":"変わり身：参","color":"yellow"}',minecraft:lore=['{"text":"右クリック: 身代わり[3]と入替","color":"gray"}','{"text":"CT: 10s (共通)","color":"aqua"}']] 1

# 全ての杖アイテムを消去
kill @e[type=item,nbt={Item:{id:"minecraft:carrot_on_a_stick"}},distance=..3]