# 1. 寿命減少
scoreboard players remove @s gadget_life 1

# 2. 演出
particle minecraft:reverse_portal ~ ~0.5 ~ 2 0 2 0.05 10
particle minecraft:witch ~ ~0.5 ~ 0.5 0.5 0.5 0 2

# 3. 吸い寄せロジック
tag @s add processing_snare
scoreboard players operation #TEMP player_id = @s player_id

# 【復旧】吸い寄せ対象を @a に戻しました
execute as @a[distance=..8] unless score @s player_id = #TEMP player_id at @s facing entity @e[tag=processing_snare,limit=1] feet run tp @s ^ ^ ^0.25

# 鈍足付与
execute as @a[distance=..8] unless score @s player_id = #TEMP player_id run effect give @s minecraft:slowness 1 2 true

tag @s remove processing_snare

# 4. 音 (定期的に鳴らす)
execute if score @s gadget_life matches 20 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 60 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 100 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5

# 5. 終了処理
execute if score @s gadget_life matches ..0 run playsound minecraft:block.beacon.deactivate ambient @a ~ ~ ~ 2 0.5
execute if score @s gadget_life matches ..0 run kill @s