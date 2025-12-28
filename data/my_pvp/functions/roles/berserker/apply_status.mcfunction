# HPを30に設定
attribute @s minecraft:generic.max_health base set 30

# ついでに全回復（リスポーン直後のため）
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true