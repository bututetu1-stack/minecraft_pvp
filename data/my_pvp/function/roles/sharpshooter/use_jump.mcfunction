# --- 狙撃手 上昇スキル: 高所確保 (sneak短) ---
# 戦場の高所に素早く移動するイメージ

# 1. スニークスコアリセット
scoreboard players set @s sneak_time 0

# 2. CDチェック
execute if score @s cd_super_jump matches 1.. run return 0

# 3. CDセット (16秒 = 320tick)
scoreboard players set @s cd_super_jump 320

# 4. 効果付与 (基準: amplifier 15)
effect give @s minecraft:levitation 1 15 true
# 着地保護 + 機動性
effect give @s minecraft:slow_falling 4 0 true

# 5. 演出
playsound minecraft:item.crossbow.loading_start master @a ~ ~ ~ 1.5 0.6
playsound minecraft:entity.arrow.shoot master @a ~ ~ ~ 1.5 0.5
particle minecraft:cloud ~ ~ ~ 0.3 0.1 0.3 0.1 15 force
particle minecraft:dust{color:[0.4,0.4,0.5],scale:0.9} ~ ~0.5 ~ 0.3 0.3 0.3 0 12 force

# 6. アクションバー
title @s actionbar [{"text":"[高所確保] ","color":"dark_gray","bold":true},{"text":"狙撃台に登る","color":"yellow"}]
