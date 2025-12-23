# 1. 直接攻撃を0にする (value:は入力しない)
attribute @s minecraft:generic.attack_damage base set 0.0

# 2. スラップの自動配布 (5秒 = 100tick ごと)
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp = #GLOBAL match_timer
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp %= #100 temp
execute if score @s temp matches 0 run scoreboard players add @s scrap 1

# 3. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 4. アイテム投下検知
function my_pvp:roles/mechanic/mechanic_place

# 5. レンチ（修理/回収）の検知
# 作成した述語（predicate）を使って、1.20.1でも正確にスニークを判定します
execute as @s[predicate=my_pvp:is_sneaking,nbt={SelectedItem:{id:"minecraft:iron_axe"}}] run function my_pvp:roles/mechanic/wrench_check