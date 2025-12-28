# ステータス強化 (体力40, KB耐性100%)
attribute @s minecraft:generic.max_health base set 40
attribute @s minecraft:generic.knockback_resistance base set 1.0

# 全回復 (リスポーン直後のため)
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true