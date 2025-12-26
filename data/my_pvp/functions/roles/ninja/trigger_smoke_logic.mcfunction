# 実行者(@s) = 落ちている木炭アイテム

# 1. 演出 (アイテムの位置で再生)
playsound minecraft:entity.generic.extinguish_fire ambient @a ~ ~ ~ 2 0.5
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 2 2 2 0.05 100
particle minecraft:large_smoke ~ ~0.5 ~ 1 1 1 0.1 50

# 2. 効果付与 (所有者IDを取得して、それ以外に盲目)
scoreboard players operation #TEMP player_id = @s player_id

# 範囲内の敵に盲目
execute as @a[distance=..4] unless score @s player_id = #TEMP player_id run effect give @s minecraft:blindness 5 0 true
execute as @a[distance=..4] unless score @s player_id = #TEMP player_id run title @s actionbar {"text":"煙に巻かれた！","color":"gray"}

# 3. アイテム消去
# kill @s は削除（親関数 process_smoke で消すため）