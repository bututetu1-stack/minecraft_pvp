# コスト支払い
scoreboard players remove @s scrap 5

# 1. タレット本体（見た目）
# Invulnerable:1b (無敵化), DisabledSlots (装備変更禁止), KnockbackResistance (押せない)
summon armor_stand ~ ~ ~ {Tags:["gadget","sentry"],Invulnerable:1b,ShowArms:1b,HandItems:[{id:"minecraft:crossbow",Count:1b},{}],Pose:{RightArm:[350f,0f,0f]},CustomName:'{"text":"Micro Sentry","color":"gold"}',Attributes:[{Name:"generic.knockback_resistance",Base:1.0f}],DisabledSlots:4144959}

# 2. 当たり判定（破壊用）
# Interaction Entityを重ねる
summon interaction ~ ~ ~ {Tags:["gadget_hitbox","sentry_hitbox"],width:0.8f,height:2.0f,response:1b}

# 3. ID設定 & HP初期化
# 本体にIDとHP(10)を設定
execute as @e[tag=gadget,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id
execute as @e[tag=gadget,limit=1,sort=nearest] run scoreboard players set @s gadget_hp 10

# 当たり判定にもIDを設定（誤爆防止用）
execute as @e[tag=gadget_hitbox,limit=1,sort=nearest] run scoreboard players operation @s player_id = @p[tag=mechanic] player_id

# 設置音
playsound minecraft:block.anvil.use ambient @a ~ ~ ~