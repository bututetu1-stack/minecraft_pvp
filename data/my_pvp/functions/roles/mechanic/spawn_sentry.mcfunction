scoreboard players remove @s scrap 5
scoreboard players set @s cd_turret 100

# 1. 本体（見た目）
# startupタグは削除しました
summon armor_stand ~ ~ ~ {Tags:["gadget","sentry","gadget_visual"],Invulnerable:1b,ShowArms:1b,HandItems:[{id:"minecraft:crossbow",Count:1b},{}],Pose:{RightArm:[350f,0f,0f]},CustomName:'{"text":"Micro Sentry","color":"gold"}',Attributes:[{Name:"generic.knockback_resistance",Base:1.0f}],DisabledSlots:4144959}

# 2. 当たり判定
summon interaction ~ ~ ~ {Tags:["gadget_hitbox","sentry_hitbox"],width:0.8f,height:2.0f,response:1b}

# 3. ID設定 & HP初期化
execute as @e[tag=gadget_visual,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id
execute as @e[tag=gadget_visual,limit=1,sort=nearest] run scoreboard players set @s gadget_hp 10

# 当たり判定にもIDを設定
execute as @e[tag=gadget_hitbox,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 【変更】設置音 (メカニック決定時と同じ音)
# 1回だけ「ガーン！」と鳴ります
playsound minecraft:block.anvil.use ambient @a ~ ~ ~ 1 1