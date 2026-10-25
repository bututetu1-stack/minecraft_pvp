# --- ステータスリセット ---
effect clear @s
# 【変更】体力40 (ハート20個)
attribute @s minecraft:max_health base set 40
attribute @s minecraft:attack_damage base set 1
attribute @s minecraft:knockback_resistance base set 0

# --- 固有ステータス: 機動力重視 ---
# 標準(0.1)より少し速い 0.11
attribute @s minecraft:movement_speed base set 0.11

# --- 全回復 ---
effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:saturation 1 255 true