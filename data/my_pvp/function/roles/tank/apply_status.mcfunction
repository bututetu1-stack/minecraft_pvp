# ステータス強化 (体力70, KB耐性100%) [40 -> 70]
attribute @s minecraft:max_health base set 70
attribute @s minecraft:knockback_resistance base set 1.0

# 全回復 (リスポーン直後のため)
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true