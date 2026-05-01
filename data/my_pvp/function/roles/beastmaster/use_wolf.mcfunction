# 狼召喚発動 (@s = beastmaster, at @s)

# CTセット (12秒 = 240tick)
scoreboard players set @s cd_beast_wolf 240

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 狼を召喚 (NoAI=1 で wolf_tick による手動制御)
# - Invulnerable なし: HP 25 で殴り殺し可能 (5発分)
# - PersistenceRequired: 自然消滅防止
summon wolf ~ ~ ~ {Tags:["beast_wolf","new_wolf"],NoAI:1b,CollarColor:7b,CustomName:'{"text":"狼","color":"gray","italic":false}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:0b}

# HP / 段差登り attribute 設定
execute as @e[tag=new_wolf,limit=1] run attribute @s minecraft:max_health base set 25
execute as @e[tag=new_wolf,limit=1] run attribute @s minecraft:step_height base set 1.0
execute as @e[tag=new_wolf,limit=1] run data modify entity @s Health set value 25.0f

# IDと攻撃タイマー設定
execute as @e[tag=new_wolf,limit=1] run scoreboard players operation @s player_id = #TEMP player_id
execute as @e[tag=new_wolf,limit=1] run scoreboard players set @s wolf_attack_timer 0

# プレイヤーの向きと同じ向きで召喚
execute store result entity @e[tag=new_wolf,limit=1] Rotation[0] float 1 run data get entity @s Rotation[0] 1

tag @e[tag=new_wolf] remove new_wolf

# 演出 (短い1音のみ)
playsound minecraft:entity.wolf.bark master @a ~ ~ ~ 1.2 1.2
particle minecraft:cloud ~ ~0.5 ~ 0.3 0.2 0.3 0.05 8 force

tellraw @s [{"text":"[狼] ","color":"gray","bold":true},{"text":"駆け出せ","color":"yellow"}]
