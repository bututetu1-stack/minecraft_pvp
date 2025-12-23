# 1. 攻撃データをリセット（連続検知防止）
data remove entity @s interaction

# 2. HP減少処理
# 近くの本体を探し、HPを1減らす
execute at @s as @e[tag=sentry,distance=..0.5,limit=1] run scoreboard players remove @s gadget_hp 1

# 3. ヒット演出（金属音）
playsound minecraft:block.anvil.land ambient @a ~ ~ ~ 0.5 1.5
particle minecraft:crit ~ ~1 ~ 0.3 0.5 0.3 0.1 5

# 4. 破壊判定
# HPが0以下になった本体を探して破壊フラグを立てる
execute at @s as @e[tag=sentry,distance=..0.5,limit=1,scores={gadget_hp=..0}] run tag @s add broken_sentry

# --- 破壊実行 ---
# 爆発エフェクトと音
execute at @e[tag=broken_sentry] run particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
execute at @e[tag=broken_sentry] run playsound minecraft:entity.generic.explode ambient @a ~ ~ ~ 1 1

# 本体を消去
kill @e[tag=broken_sentry]
# 近くの当たり判定(@s)も道連れに消去
execute if entity @e[tag=broken_sentry] run kill @s