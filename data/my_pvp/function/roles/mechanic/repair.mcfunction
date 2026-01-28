# 実行者: Hitbox (@s)
# 対象: 持ち主 (@p[tag=owner_temp])

# 1. コストチェック
# 持ち主のスクラップが1未満ならエラー音
execute unless score @p[tag=owner_temp] scrap matches 1.. run playsound minecraft:ui.button.click master @p[tag=owner_temp] ~ ~ ~ 1 2
execute unless score @p[tag=owner_temp] scrap matches 1.. run return 0

# 2. コスト消費
scoreboard players remove @p[tag=owner_temp] scrap 1

# 3. 回復処理
# 【修正】HPを全快(5)にする (元: 10)
execute at @s as @e[tag=gadget_visual,distance=..1,limit=1] run scoreboard players set @s gadget_hp 5

# 4. 演出
particle minecraft:crit ~ ~0.5 ~ 0.2 0.2 0.2 0.1 5
playsound minecraft:block.anvil.place ambient @a ~ ~ ~ 0.3 2.0