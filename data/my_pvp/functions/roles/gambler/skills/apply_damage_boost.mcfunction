# 通常攻撃のダメージ2倍処理
# @s = attacker (Gambler with damage_boost=1)

# 1. 前回の攻撃ダメージを算出
scoreboard players operation #dmg temp = @s damage_dealt
scoreboard players operation #dmg temp -= @s last_damage_dealt

# 2. ダメージが0以下の場合は処理しない (念のため)
execute if score #dmg temp matches ..0 run return 0

# 3. 近くの敵(ダメージを受けた対象)を特定
# distance=..6 (攻撃届く範囲), sort=nearest
tag @s add attacker
tag @e[distance=..6,limit=1,sort=nearest,tag=!attacker] add victim

# 4. 追加ダメージを与える
tellraw @s {"text":"[Fate] ダメージブースト発動!","color":"aqua"}
execute as @a[tag=victim] run damage @s 0 minecraft:magic source @p[tag=attacker]
# ユーザー要望: 無敵時間(I-frame)を無視してダメージを与える
# HurtTimeを0にすることで、直前の攻撃による無敵時間を解除する
execute as @a[tag=victim] run data modify entity @s HurtTime set value 0s
execute as @a[tag=victim] run damage @s 7 minecraft:generic

# 5. フラグ消費 & 後処理
scoreboard players set @s damage_boost 0
tag @s remove attacker
tag @e[tag=victim] remove victim
