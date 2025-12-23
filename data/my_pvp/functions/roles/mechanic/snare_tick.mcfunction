# 1. 寿命を減らす
scoreboard players remove @s gadget_life 1

# 2. 吸引エフェクト
particle minecraft:reverse_portal ~ ~1 ~ 3 0 3 0.1 10
particle minecraft:witch ~ ~0.5 ~ 0.5 0.5 0.5 0 2

# 3. 吸引ロジック
execute as @a[distance=..7] unless score @s player_id = @e[tag=snare,limit=1,distance=..7] player_id at @s facing entity @e[tag=snare,limit=1,distance=..7] feet run tp @s ^ ^ ^0.2

# 4. 鈍足付与
execute as @a[distance=..7] unless score @s player_id = @e[tag=snare,limit=1,distance=..7] player_id run effect give @s minecraft:slowness 1 2 true

# 5. 効果音（修正箇所）
# matches はカンマ区切りが使えないため、個別に記述します
execute if score @s gadget_life matches 20 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 40 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 60 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 80 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 100 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5

# 6. 終了処理
execute if score @s gadget_life matches ..0 run playsound minecraft:block.beacon.deactivate ambient @a ~ ~ ~ 2 0.5
execute if score @s gadget_life matches ..0 run kill @s