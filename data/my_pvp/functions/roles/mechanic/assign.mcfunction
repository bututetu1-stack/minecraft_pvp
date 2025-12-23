# 1. タグ付け
tag @s add mechanic
tag @s add role_assigned

# 2. アナウンス（自分にだけ表示）
title @s title {"text":"YOU ARE MECHANIC","color":"gold","bold":true}
title @s subtitle {"text":"ガジェットを駆使して戦場を支配せよ","color":"yellow"}

# 3. アイテム配布（既存の関数を呼び出し）
function my_pvp:system/give_mechanic_items

# 4. 効果音
playsound minecraft:block.anvil.use master @s ~ ~ ~ 1 1