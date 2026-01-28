# コスト消費 (8 -> 7)
scoreboard players remove @s scrap 7
scoreboard players set @s cd_turret 100

# ... (以降変更なし)
# --- 設置上限チェック (Max 5) ---
# 1. 自分のIDを確保
scoreboard players operation #TEMP player_id = @s player_id
# 2. 自分のタレットだけを特定してタグ付け
tag @e remove my_sentry_temp
execute as @e[tag=sentry] if score @s player_id = #TEMP player_id run tag @s add my_sentry_temp
# 3. 数をカウント
execute store result score #SENTRY_COUNT temp if entity @e[tag=my_sentry_temp]
# 4. 5個以上あるなら、最も古い1つを削除
execute if score #SENTRY_COUNT temp matches 5.. run tag @e[tag=my_sentry_temp,limit=1] add sentry_to_delete
# 【修正】削除対象(Visual)と重なっているHitboxだけをピンポイントで削除
execute at @e[tag=sentry_to_delete] run kill @e[tag=sentry_hitbox,distance=..0.5,limit=1]
# 演出
execute at @e[tag=sentry_to_delete] run playsound minecraft:block.fire.extinguish ambient @a ~ ~ ~ 1 1
execute at @e[tag=sentry_to_delete] run particle minecraft:smoke ~ ~1 ~ 0.5 0.5 0.5 0.1 10
# 本体(Visual)を削除
kill @e[tag=sentry_to_delete]

# --- 以下、召喚処理 ---
# 1. 本体（見た目）
summon armor_stand ~ ~ ~ {Tags:["gadget","sentry","gadget_visual"],Invulnerable:1b,ShowArms:1b,HandItems:[{id:"minecraft:crossbow",count:1},{}],Pose:{RightArm:[350f,0f,0f]},CustomName:'{"text":"Micro Sentry","color":"gold"}',attributes:[{id:"minecraft:generic.knockback_resistance",base:1.0f}],DisabledSlots:4144959}
# 2. 当たり判定
summon interaction ~ ~ ~ {Tags:["gadget_hitbox","sentry_hitbox"],width:0.8f,height:2.0f,response:1b}
# 3. ID設定 & HP初期化
execute as @e[tag=gadget_visual,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id
execute as @e[tag=gadget_visual,limit=1,sort=nearest] run scoreboard players set @s gadget_hp 5
# 当たり判定にもIDを設定
execute as @e[tag=gadget_hitbox,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id
# 設置音
playsound minecraft:block.anvil.use ambient @a ~ ~ ~ 1 1