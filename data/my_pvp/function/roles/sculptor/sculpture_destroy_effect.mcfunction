# 彫刻破壊エフェクト
# @s = 破壊される彫刻本体 (sculpture)

# --- 回復の彫刻: 破壊者にHP回復 ---
execute if entity @s[tag=sculpture_heal] as @a[tag=current_attacker] run effect give @s minecraft:instant_health 1 1 true
execute if entity @s[tag=sculpture_heal] as @a[tag=current_attacker] run tellraw @s [{"text":"[彫刻] ","color":"gray"},{"text":"回復の彫刻を破壊してHPが回復した！","color":"green"}]

# --- 共通: 破壊演出 ---
playsound minecraft:block.stone.break master @a ~ ~ ~ 1 0.8
particle minecraft:cloud ~ ~1 ~ 0.3 0.5 0.3 0.05 15

# 本体削除
kill @s
