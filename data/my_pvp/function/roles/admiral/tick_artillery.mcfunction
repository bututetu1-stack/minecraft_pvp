# 【追加】凍結中は処理を停止
execute if entity @s[tag=is_frozen] run return 0

# カウントダウン
scoreboard players remove @s temp 1

# --- リング描画アニメーション ---
# マーカーを回転させる (Pitch=0で水平固定、Yawを回転)
# 回転速度: 1tickあたり13度
tp @s ~ ~ ~ ~13 0

# 解説:
# 地面へのめり込みを防ぐため、'positioned ~ ~1.3 ~' を挟んで
# 描画起点を1.3ブロック上にずらしています。

# === A. 戦艦大和 (半径15m) ===
# 層: 15m, 11m, 7m, 3m
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^15 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^11 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^7 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^3 0 0 0 0 1 force

execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^-15 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^-11 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^-7 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^-3 0 0 0 0 1 force

# 斜め方向補完
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^15 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^11 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^-15 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^-11 ^ ^ 0 0 0 0 1 force

# 炎(Flame)
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle minecraft:flame ^ ^ ^15 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle minecraft:flame ^-15 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle minecraft:flame ^ ^ ^-15 0 0 0 0 1 force
execute if entity @s[tag=type_yamato] positioned ~ ~1.3 ~ run particle minecraft:flame ^15 ^ ^ 0 0 0 0 1 force


# === B. 戦艦金剛 (半径8m) ===
# 層: 8m, 5m, 2m
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^ ^ ^8 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^ ^ ^5 0 0 0 0 1 force
# 警告エフェクト: 落下点にパーティクル
# オレンジのダスト
execute at @s run particle dust{color:[1.0,0.6,0.0],scale:1.5} ~ ~0.2 ~ 0.5 0.5 0.5 1 5 normal
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^ ^ ^2 0 0 0 0 1 force

execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^ ^ ^-8 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^ ^ ^-5 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^ ^ ^-2 0 0 0 0 1 force

execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^8 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^5 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^-8 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle dust{color:[1.0,0.8,0.0],scale:2.0} ^-5 ^ ^ 0 0 0 0 1 force

# スパーク
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle minecraft:electric_spark ^ ^ ^8 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle minecraft:electric_spark ^8 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle minecraft:electric_spark ^ ^ ^-8 0 0 0 0 1 force
execute if entity @s[tag=type_kongo] positioned ~ ~1.3 ~ run particle minecraft:electric_spark ^-8 ^ ^ 0 0 0 0 1 force


# === C. 戦艦長門 (半径10m) ===
# 層: 10m, 7m, 4m, 1m
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^ ^ ^10 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^ ^ ^7 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^ ^ ^4 0 0 0 0 1 force

execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^ ^ ^-10 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^ ^ ^-7 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^ ^ ^-4 0 0 0 0 1 force

execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^10 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^7 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^-10 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle dust{color:[0.5,0.0,1.0],scale:2.0} ^-7 ^ ^ 0 0 0 0 1 force

# 黒煙
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle minecraft:large_smoke ^ ^ ^10 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle minecraft:large_smoke ^10 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle minecraft:large_smoke ^ ^ ^-10 0 0 0 0 1 force
execute if entity @s[tag=type_nagato] positioned ~ ~1.3 ~ run particle minecraft:large_smoke ^-10 ^ ^ 0 0 0 0 1 force


# --- 音 ---
execute if score @s temp matches 80 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1
execute if score @s temp matches 60 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1
execute if score @s temp matches 40 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1
execute if score @s temp matches 20 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 2

# --- 着弾 ---
execute if score @s temp matches ..0 run function my_pvp:roles/admiral/process_explosion