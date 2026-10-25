# Restore HP Macro
# Arguments: $(hp) - Health value to restore

# 1. 一時的に最大HPを「戻したいHP」に変更
$attribute @s minecraft:max_health base set $(hp)

# 2. 即時回復で埋める
# ※ amplifier 255 は回復量が 0 になる (4<<255 がオーバーフロー) ため 10 を使う
effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:saturation 1 255 true

# 3. 最大HPを元に戻す (現在はみ出た分は消滅し、現在のHPが $(hp) に一致する)
attribute @s minecraft:max_health base set 40
