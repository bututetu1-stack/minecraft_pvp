# チャット欄に黄色で警告を送る
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"⚠ スキルはまだ準備中（リチャージ中）です。","color":"yellow"}]

# 準備中であることを示す音
playsound minecraft:block.iron_trapdoor.close ambient @s ~ ~ ~ 1 0.5