# チャット欄に赤文字で警告を送る（1回だけ表示される）
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"⚠ スクラップが足りません！","color":"red","bold":true}]

# 鈍い音を鳴らす
playsound minecraft:block.note_block.bass ambient @s ~ ~ ~ 1 0.6