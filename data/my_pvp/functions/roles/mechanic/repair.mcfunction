# 1. コストチェック
# スクラップが1以上あるか確認。なければエラー音を出して終了
execute as @p[tag=mechanic] unless score @s scrap matches 1.. run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2
execute as @p[tag=mechanic] unless score @s scrap matches 1.. run return 0

# 2. コスト消費
scoreboard players remove @p[tag=mechanic] scrap 1

# 3. 回復処理
# ガジェットの体力を最大値（10.0）まで回復させる
data modify entity @s Health set value 10.0f
# 内部的なHPスコア（破壊判定用）も10に戻す
scoreboard players set @s gadget_hp 10

# 4. 演出
particle minecraft:crit ~ ~0.5 ~ 0.2 0.2 0.2 0.1 5
playsound minecraft:block.anvil.place ambient @p ~ ~ ~ 0.3 2.0