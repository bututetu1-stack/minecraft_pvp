# --- 1. 演出 (Visuals - Always Run) ---
particle minecraft:reverse_portal ~ ~0.5 ~ 2 0 2 0.05 10
particle minecraft:witch ~ ~0.5 ~ 0.5 0.5 0.5 0 2

# --- 2. 凍結チェック (Frozen Check) ---
execute if entity @s[tag=is_frozen] run return 0

# --- 3. ロジック (Logic) ---

# 寿命減少
scoreboard players remove @s gadget_life 1

# 吸い寄せロジック
tag @s add processing_snare
scoreboard players operation #TEMP player_id = @s player_id

# 【修正】吸い寄せ力を 0.12 に設定
# Slowness Lv3の歩行速度(約0.118)とほぼ拮抗させます。
# これにより「歩けばその場で耐えられるが、外には進めない」強度になります。
execute as @a[distance=..8] unless score @s player_id = #TEMP player_id at @s facing entity @e[tag=processing_snare,limit=1] feet run tp @s ^ ^ ^0.08

# 鈍足付与 (Slowness 1 2 = Level 3 [-45%速度])
execute as @a[distance=..8] unless score @s player_id = #TEMP player_id run effect give @s minecraft:slowness 1 2 true

tag @s remove processing_snare

# 音 (定期的に鳴らす)
execute if score @s gadget_life matches 20 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 60 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5
execute if score @s gadget_life matches 100 run playsound minecraft:block.respawn_anchor.ambient ambient @a ~ ~ ~ 1 0.5

# 終了処理
execute if score @s gadget_life matches ..0 run playsound minecraft:block.beacon.deactivate ambient @a ~ ~ ~ 2 0.5
execute if score @s gadget_life matches ..0 run kill @s