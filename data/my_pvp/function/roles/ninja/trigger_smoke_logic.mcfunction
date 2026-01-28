# 実行者(@s) = 落ちている木炭アイテム

# 1. 演出
playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 2 0.5
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 2 2 2 0.05 100
particle minecraft:large_smoke ~ ~0.5 ~ 1 1 1 0.1 50

# 2. 効果付与
scoreboard players operation #TEMP player_id = @s player_id

# A. 範囲内の敵に盲目
execute as @a[distance=..4] unless score @s player_id = #TEMP player_id run effect give @s minecraft:blindness 5 0 true
# 敵への通知もtellrawに変更（警告として分かりやすく）
execute as @a[distance=..4] unless score @s player_id = #TEMP player_id run tellraw @s {"text":"[!] 煙玉により視界を奪われた！","color":"red"}

# B. 範囲内の自分に透明化 (10秒)
execute as @a[tag=ninja,distance=..4] if score @s player_id = #TEMP player_id run effect give @s minecraft:invisibility 10 0 true
# 自分への通知もtellrawに変更
execute as @a[tag=ninja,distance=..4] if score @s player_id = #TEMP player_id run tellraw @s {"text":"[Ninja] 煙に紛れて姿を消した (透明化 10秒)","color":"green","italic":true}

# 3. アイテム消去
# kill @s は親関数で処理