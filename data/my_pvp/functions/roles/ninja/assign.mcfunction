# 1. 役職タグ設定
tag @s add ninja
tag @s add role_assigned

# 2. UI表示
title @s title {"text":"YOU ARE NINJA","color":"dark_purple","bold":true}
title @s subtitle {"text":"神速の移動と変わり身の術","color":"gray"}

# 3. インベントリ完全リセット (これが重複を防ぎます)
clear @s

# 4. アイテム配布
# 忍刀
give @s minecraft:iron_sword{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4,Operation:0,UUID:[I;114,514,1919,810],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-2.4,Operation:0,UUID:[I;114,514,1919,811],Slot:"mainhand"}],display:{Name:'{"text":"忍刀","color":"white"}',Lore:['{"text":"攻撃力: 中","color":"gray"}']},HideFlags:2} 1

# 影縫い
scoreboard players set @s slot_cycle 1
give @s minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# 変わり身の術 x3
give @s minecraft:carrot_on_a_stick{CustomModelData:1,display:{Name:'{"text":"変わり身：壱","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[1]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_1"]} 1
give @s minecraft:carrot_on_a_stick{CustomModelData:2,display:{Name:'{"text":"変わり身：弐","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[2]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_2"]} 1
give @s minecraft:carrot_on_a_stick{CustomModelData:3,display:{Name:'{"text":"変わり身：参","color":"yellow"}',Lore:['{"text":"右クリック: 身代わり[3]と入替","color":"gray"}','{"text":"CT: 15s (共通)","color":"aqua"}']},Tags:["ninja_tool","swap_3"]} 1

# 煙玉
give @s minecraft:charcoal{display:{Name:'{"text":"煙玉 (目眩まし)","color":"gray"}',Lore:['{"text":"Q: 投げて範囲盲目","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# 5. 音
playsound minecraft:entity.illusioner.prepare_mirror master @s ~ ~ ~ 1 1