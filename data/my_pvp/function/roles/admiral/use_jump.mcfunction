# --- 提督 上昇スキル: 対空射出 (AA Launch) ---
# 戦闘機の発艦のように軽快に射出される

# 1. スニークスコアリセット
scoreboard players set @s sneak_time 0

# 2. CDチェック
execute if score @s cd_adm_jump matches 1.. run return 0

# 3. CDセット (16秒 = 320tick)
scoreboard players set @s cd_adm_jump 320

# 4. 効果付与
# 上昇 (基準: amplifier 15)
effect give @s minecraft:levitation 1 15 true
# 着地後の機動性 (速度I, 2秒)
effect give @s minecraft:speed 2 0 true

# 5. 演出
playsound minecraft:entity.phantom.swoop master @a ~ ~ ~ 2 1.4
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1.5 1.4
particle minecraft:firework ~ ~0.5 ~ 0.3 0.3 0.3 0.2 30 force
particle minecraft:cloud ~ ~ ~ 0.4 0 0.4 0.1 20
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force

# 6. アクションバー
title @s actionbar [{"text":"[対空射出] ","color":"dark_aqua","bold":true},{"text":"発艦！","color":"yellow"}]
