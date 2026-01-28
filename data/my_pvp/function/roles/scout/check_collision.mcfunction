# 1. 判定用フラグを立てる (一旦「移動可能」とする)
tag @s add can_move

# 2. 足元(feet)のチェック
# 進む先(1.2マス前)が空気以外なら、移動不可フラグを立てる
execute unless block ^ ^ ^1.2 minecraft:air unless block ^ ^ ^1.2 minecraft:cave_air unless block ^ ^ ^1.2 minecraft:light unless block ^ ^ ^1.2 minecraft:water run tag @s remove can_move

# 3. 頭(head)のチェック
# 視点座標ではなく「足元から1.8マス上」を基準に、進む先をチェック
# これで「足元のブロックは超えられるが、頭が天井にぶつかる」ケースなどを防げます
execute unless block ^ ^1.8 ^1.2 minecraft:air unless block ^ ^1.8 ^1.2 minecraft:cave_air unless block ^ ^1.8 ^1.2 minecraft:light unless block ^ ^1.8 ^1.2 minecraft:water run tag @s remove can_move


# 4. 結果による分岐
# 移動OKならテレポート
execute if entity @s[tag=can_move] run tp @s ^ ^ ^1.2

# 移動不可(障害物あり)ならワイヤー終了
execute unless entity @s[tag=can_move] run function my_pvp:roles/scout/stop_grapple

# 後片付け
tag @s remove can_move
