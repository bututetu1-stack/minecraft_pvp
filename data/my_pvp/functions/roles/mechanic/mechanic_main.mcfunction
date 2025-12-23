# 1. 【変更】属性変更ではなく、弱体化エフェクトで攻撃を無効化
# レベル255の弱体化を付与し続けることで、斧を持ってもダメージ0になります
# show_particles:false でパーティクルを消しています
effect give @s minecraft:weakness 2 255 true

# 2. スクラップの自動配布
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp = #GLOBAL match_timer
execute if score #GLOBAL match_timer matches 1.. run scoreboard players operation @s temp %= #100 temp
execute if score @s temp matches 0 run scoreboard players add @s scrap 1

# 3. UI表示
title @s actionbar [{"text":"SCRAP: ","color":"gold"},{"score":{"name":"@s","objective":"scrap"},"color":"white"}]

# 4. 設置クールダウンの消化（3種独立）
scoreboard players remove @s[scores={cd_turret=1..}] cd_turret 1
scoreboard players remove @s[scores={cd_mine=1..}] cd_mine 1
scoreboard players remove @s[scores={cd_launcher=1..}] cd_launcher 1

# スコア未設定(null)の場合は0にする
execute unless score @s cd_turret matches 0.. run scoreboard players set @s cd_turret 0
execute unless score @s cd_mine matches 0.. run scoreboard players set @s cd_mine 0
execute unless score @s cd_launcher matches 0.. run scoreboard players set @s cd_launcher 0

# 5. レンチ（修理/回収）の検知
execute as @s[predicate=my_pvp:is_sneaking,nbt={SelectedItem:{id:"minecraft:iron_axe"}}] run function my_pvp:roles/mechanic/wrench_check