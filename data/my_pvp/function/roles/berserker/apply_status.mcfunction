# HPを60に設定 (30 -> 60)
attribute @s minecraft:max_health base set 60

# ついでに全回復（リスポーン直後のため）
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true