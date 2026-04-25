# --- 時空跳躍者 上昇スキル: 時空跳躍 (Spacetime Jump) ---
# 時空を曲げて軽やかに跳躍。落下も時間操作で緩やかに

# 1. スニークスコアリセット
scoreboard players set @s sneak_time 0

# 2. CDチェック
execute if score @s cd_chrono_jump matches 1.. run return 0

# 3. CDセット (16秒 = 320tick)
scoreboard players set @s cd_chrono_jump 320

# 4. 効果付与
# 上昇 (基準: amplifier 15)
effect give @s minecraft:levitation 1 15 true
# 時間遅延テーマ: 緩落下5秒
effect give @s minecraft:slow_falling 5 0 true

# 5. 演出
playsound minecraft:item.chorus_fruit.teleport master @a ~ ~ ~ 1.5 1.5
playsound minecraft:block.beacon.activate master @a ~ ~ ~ 1 2
particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.5 0.5 0.5 40 force
particle minecraft:end_rod ~ ~0.3 ~ 0.3 0.5 0.3 0.05 20
particle minecraft:enchant ~ ~1 ~ 0.5 0.5 0.5 1 30

# 6. アクションバー
title @s actionbar [{"text":"[時空跳躍] ","color":"yellow","bold":true},{"text":"時を超える","color":"aqua"}]
