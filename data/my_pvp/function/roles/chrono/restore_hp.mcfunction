# Restore HP Macro
# Arguments: $(hp) - Health value to restore

# 1. 一時的に最大HPを「戻したいHP」に変更
$attribute @s minecraft:max_health base set $(hp)

# 2. 即時回復で埋める
# ※ amplifier 255 は回復量が 0 になる (4<<255 がオーバーフロー) ため 10 を使う
effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:saturation 1 255 true

# 3. 最大HPを元に戻すのは次のtick (chrono_main) で行う
# ※ /effect の即時回復はこのtickのエンティティ処理で適用されるため、ここで 40 に戻すと
#    記録値ではなく満タンまで回復してしまう。それまでの間はリスポーン検知 (最大HPの変化) の対象外にする
tag @s add chrono_restore_max
tag @s add ignore_status_check
