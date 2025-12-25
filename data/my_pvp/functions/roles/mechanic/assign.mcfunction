# 1. タグ付け (これがないと何も始まりません)
tag @s add mechanic
tag @s add role_assigned

# 2. アナウンス
# 表示時間を設定 (フェードイン0.5秒, 表示3.5秒, フェードアウト1秒)
title @s times 10 70 20
title @s title {"text":"YOU ARE MECHANIC","color":"gold","bold":true}
title @s subtitle {"text":"ガジェットを駆使して戦場を支配せよ","color":"yellow"}

# 3. 基礎攻撃力を0にする
# 万が一エラーが出ても進行するように、アイテム配布の前に置きます
attribute @s minecraft:generic.attack_damage base set 0

# 4. アイテム配布
function my_pvp:system/give_mechanic_items

# 5. 効果音
playsound minecraft:block.anvil.use master @s ~ ~ ~ 1 1