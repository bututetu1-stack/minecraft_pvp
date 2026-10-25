# --- 獣使い 上昇スキル: 獣の翼 (sneak短) ---
# 鳥の召喚獣に持ち上げてもらうイメージ

# 1. スニークスコアリセット
scoreboard players set @s sneak_time 0

# 2. CDチェック
execute if score @s cd_super_jump matches 1.. run return 0

# 3. CDセット (16秒 = 320tick)
scoreboard players set @s cd_super_jump 320

# 4. 効果付与 (基準: amplifier 15)
effect give @s minecraft:levitation 1 15 true

# 5. 演出
playsound minecraft:entity.parrot.fly master @a ~ ~ ~ 1.5 1.0
playsound minecraft:entity.bat.takeoff master @a ~ ~ ~ 1.2 1.3
playsound minecraft:entity.wolf.howl master @s ~ ~ ~ 0.5 1.5
particle minecraft:cloud ~ ~ ~ 0.4 0.1 0.4 0.15 20 force
particle minecraft:dust{color:[0.5,0.5,0.5],scale:0.9} ~ ~0.5 ~ 0.3 0.3 0.3 0 15 force

# 6. アクションバー
title @s actionbar [{"text":"[獣の翼] ","color":"gray","bold":true},{"text":"鳥よ、運べ","color":"yellow"}]
