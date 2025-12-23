# コスト支払い
scoreboard players remove @s scrap 5

# 【変更点】
# 1. Small:1b を削除しました -> 通常サイズ（約2倍の大きさ）になります
# 2. HandItems を追加し、右手にクロスボウを持たせました
# 3. Pose を追加し、少し構えているような角度をつけました（お好みで）
summon armor_stand ~ ~ ~ {Tags:["gadget","sentry"],Health:10f,ShowArms:1b,HandItems:[{id:"minecraft:crossbow",Count:1b},{}],Pose:{RightArm:[350f,0f,0f]},CustomName:'{"text":"Micro Sentry","color":"gold"}'}

# IDコピー
execute as @e[tag=gadget,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 設置音
playsound minecraft:block.anvil.use ambient @a ~ ~ ~