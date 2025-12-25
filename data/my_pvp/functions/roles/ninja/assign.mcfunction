# デバッグ: 開始ログ
tellraw @a {"text":"[Debug] Ninja Assign Started for: ","color":"red","extra":[{"selector":"@s"}]}

# 1. 役職タグ設定
tag @s add ninja
tag @s add role_assigned

# 2. UI表示
title @s title {"text":"YOU ARE NINJA","color":"dark_purple","bold":true}
title @s subtitle {"text":"神速の移動と変わり身の術","color":"gray"}

# 3. インベントリ初期化
clear @s

# 4. 変数初期化
scoreboard players set @s slot_cycle 1
scoreboard players set @s cd_ninja_mark 0
scoreboard players set @s cd_ninja_swap 0
scoreboard players set @s cd_ninja_smoke 0

# 5. アイテム配布 (専用関数呼び出し)
function my_pvp:system/give_ninja_items

# 6. 音
playsound minecraft:entity.illusioner.prepare_mirror master @s ~ ~ ~ 1 1

# デバッグ: 完了ログ
tellraw @a {"text":"[Debug] Ninja Assign Completed.","color":"red"}