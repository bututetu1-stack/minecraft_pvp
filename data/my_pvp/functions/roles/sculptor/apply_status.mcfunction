# リスポーン時のステータス適用
# HP 40 (標準)
attribute @s minecraft:generic.max_health base set 40
effect give @s minecraft:instant_health 1 100 true

# アイテム再配布
function my_pvp:system/give_sculptor_items
