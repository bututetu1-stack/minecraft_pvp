# 炎玉ヒット処理

# 1. ダメージを与える (ハート3個分 = 6HP)
execute at @s run damage @a[distance=..1.5,limit=1,sort=nearest] 6 minecraft:magic

# 2. ヒットエフェクト
particle minecraft:flame ~ ~1 ~ 0.3 0.3 0.3 0.1 20
execute at @s run playsound minecraft:entity.blaze.hurt master @a[distance=..1.5,limit=1,sort=nearest] ~ ~ ~ 1 1

# 3. 炎玉を消す
kill @s
