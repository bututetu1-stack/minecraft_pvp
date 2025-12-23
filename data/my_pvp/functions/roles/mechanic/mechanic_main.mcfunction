# 1. 直接攻撃を0にする (1.20.1の属性操作)
attribute @s minecraft:generic.attack_damage base set 0.0

# 2. スラップの自動配布 (5秒 = 100tick ごと)
# match_timerが100で割り切れる時に配布
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp = #GLOBAL match_timer
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp %= #100 dummy
execute if score @s temp matches 0 run scoreboard players add @s scrap 1

# 3. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 4. アイテム投下検知
function my_pvp:roles/mechanic/mechanic_place

# --- 5. レンチ（リサイクル/修理）の検知 ---
# 鉄の斧をメインハンドに持っている時だけ「レンチ機能」を呼び出す
execute if entity @s[nbt={SelectedItem:{id:"minecraft:iron_axe"}}] run function my_pvp:roles/mechanic/wrench_check