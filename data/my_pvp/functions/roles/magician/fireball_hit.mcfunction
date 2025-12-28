# 炎玉ヒット処理

# 1. ダメージを与える (ハート1個分 = 2HP)
damage @a[tag=mag_fb_target,limit=1,sort=nearest] 2 minecraft:magic

# 2. ヒットエフェクト
particle minecraft:flame ~ ~1 ~ 0.3 0.3 0.3 0.1 20
playsound minecraft:entity.blaze.hurt master @a ~ ~ ~ 1 1

# 3. 炎玉を消す
kill @s
