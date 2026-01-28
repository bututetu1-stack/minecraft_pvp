# Orphan Cleanup
# センターが存在しない(死んだ/消えた)のに残っているファントムを消す
# 自分のIDと同じIDを持つ airstrike_center が存在するか確認

# 1. 親存在チェック
tag @s add orphan_check
tag @s remove has_parent

# ID取得 (存在確認)
scoreboard players set #HAS_ID temp 0
execute store success score #HAS_ID temp run scoreboard players operation #MY_ID temp = @s player_id

# 2. 親存在チェック (IDがある場合のみ)
execute if score #HAS_ID temp matches 1 as @e[tag=airstrike_center] if score @s player_id = #MY_ID temp run tag @e[tag=orphan_check,limit=1] add has_parent

# 3. 親がいなければ死亡 (IDなし or 親なし)
# 3. 親がいなければ死亡 (IDなし or 親なし)
execute unless entity @s[tag=has_parent] run data modify entity @s Invulnerable set value 0b
execute unless entity @s[tag=has_parent] run tp @s ~ -100 ~
execute unless entity @s[tag=has_parent] run kill @s

# 3. 後始末
tag @s remove orphan_check
tag @s remove has_parent
