# チャット欄に黄色で警告を送る
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"⚠ スキルはまだ準備中（リチャージ中）です。","color":"yellow"}]

# 準備中（オーバーヒート）であることを示す音
# 地雷設置音と区別するため、「ジューッ」という焼き切れ音に変更
playsound minecraft:block.redstone_torch.burnout ambient @s ~ ~ ~ 1 1