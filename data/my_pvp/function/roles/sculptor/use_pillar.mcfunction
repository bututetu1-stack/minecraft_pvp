# --- 彫刻家 上昇スキル: 石柱噴出 (Stone Pillar Burst) ---
# 足元から石柱が噴き出して持ち上げる

# 1. スニークスコアリセット
scoreboard players set @s sneak_time 0

# 2. CDチェック
execute if score @s cd_sculptor_pillar matches 1.. run return 0

# 3. CDセット (18秒 = 360tick)
scoreboard players set @s cd_sculptor_pillar 360

# 4. 効果付与
# 上昇 (基準: amplifier 15)
effect give @s minecraft:levitation 1 15 true
# 石化防御テーマ: 耐性II 2秒
effect give @s minecraft:resistance 2 1 true

# 5. 演出
playsound minecraft:block.stone.break master @a ~ ~ ~ 1.5 0.6
playsound minecraft:block.stone.place master @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.iron_golem.repair master @a ~ ~ ~ 1 0.7
# 石柱が噴き上がる演出 (足元から空中まで)
particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~ ~ 0.4 0 0.4 0 30 force
particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~2 ~ 0.4 0.5 0.4 0 25 force
particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~4 ~ 0.4 0.5 0.4 0 20 force
particle minecraft:block{block_state:{Name:"minecraft:stone"}} ~ ~0.5 ~ 0.5 0.3 0.5 0.1 30 force

# 6. アクションバー
title @s actionbar [{"text":"[石柱噴出] ","color":"blue","bold":true},{"text":"大地より生ず","color":"gray"}]
