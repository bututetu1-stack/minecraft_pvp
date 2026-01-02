# === 0: 単縦陣 (Line Ahead) - 通常状態 ===
# メリット: 攻撃力上昇 (Strength I)
# デメリット: なし
# これが基本形態となり、殴り合いや砲撃戦で火力を出せます
execute if score @s adm_formation matches 0 run effect give @s minecraft:strength 1 0 true

# === 1: 輪形陣 (Diamond) - 耐える ===
# メリット: 耐性 (Resistance I)
# デメリット: 弱体化 (Weakness I)
# 敵の攻撃を耐える時や、対空カットイン中に使用します
execute if score @s adm_formation matches 1 run effect give @s minecraft:resistance 1 0 true
execute if score @s adm_formation matches 1 run effect give @s minecraft:weakness 1 0 true

# === 2: 警戒陣 (Cruising) - 移動 ===
# メリット: 移動速度上昇 (Speed II)
# デメリット: 弱体化 II (Weakness II)
# 逃げる時や位置取りに使いますが、攻撃力は大幅に下がります
execute if score @s adm_formation matches 2 run effect give @s minecraft:speed 1 1 true
execute if score @s adm_formation matches 2 run effect give @s minecraft:weakness 1 1 true

# --- CT消化 ---
scoreboard players remove @s[scores={cd_formation=1..}] cd_formation 1