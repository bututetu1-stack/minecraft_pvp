# 1. UI表示
title @s actionbar [{"text":"BERSERKER STATUS","color":"red","bold":true}]

# 2. クールダウン消化 & アイテム返却

# ブラッドレイド (赤染料)
# CTが明けたら Slot 2 に返却
execute as @s[scores={cd_ber_raid=1}] run item replace entity @s container.2 with minecraft:red_dye{berserker_raid:1b,display:{Name:'{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',Lore:['{"text":"Q: ブラッドレイド (Cost: 4HP)","color":"gray"}','{"text":"周囲をなぎ払い、敵を吹き飛ばす","color":"dark_red"}','{"text":"CT: 5s","color":"aqua"}']}} 1
execute as @s[scores={cd_ber_raid=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 0.5
scoreboard players remove @s[scores={cd_ber_raid=1..}] cd_ber_raid 1

# リープ (羽根)
execute as @s[scores={cd_ber_jump=1}] run item replace entity @s container.1 with minecraft:feather{berserker_jump:1b,display:{Name:'{"text":"リープフェザー","color":"green","bold":true}',Lore:['{"text":"Q: 大ジャンプ","color":"gray"}','{"text":"CT: 8s","color":"aqua"}']}} 1
execute as @s[scores={cd_ber_jump=1}] run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
scoreboard players remove @s[scores={cd_ber_jump=1..}] cd_ber_jump 1