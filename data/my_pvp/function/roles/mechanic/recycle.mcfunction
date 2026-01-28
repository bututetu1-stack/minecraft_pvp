# 実行者: Hitbox (@s)

# 1. スクラップ返却 (殴った本人へ)
execute if entity @a[tag=current_attacker] run scoreboard players add @a[tag=current_attacker,limit=1] scrap 2

# 2. 演出 (キンッ！)
# 爆破エフェクトは削除し、高めの金属音だけにします
playsound minecraft:block.anvil.land ambient @a ~ ~ ~ 0.8 2.0

# 3. 本体(Visual)の削除
execute at @s run kill @e[tag=gadget_visual,distance=..1,limit=1]

# 4. 自分(Hitbox)の削除
kill @s