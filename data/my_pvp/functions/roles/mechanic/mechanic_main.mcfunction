# 1. 攻撃力0
attribute @s minecraft:generic.attack_damage base set 0.0

# 2. スクラップの自動配布
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp = #GLOBAL match_timer
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp %= #100 temp
execute if score @s temp matches 0 run scoreboard players add @s scrap 1

# 3. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 4. 【追加】設置クールダウンの消化
# 1以上なら1減らす
scoreboard players remove @s[scores={place_cd=1..}] place_cd 1

# 5. レンチ（修理/回収）の検知
execute as @s[predicate=my_pvp:is_sneaking,nbt={SelectedItem:{id:"minecraft:iron_axe"}}] run function my_pvp:roles/mechanic/wrench_check