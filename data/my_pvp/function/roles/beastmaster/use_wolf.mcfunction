# 狼召喚発動 (@s = beastmaster, at @s)

# CTセット (12秒 = 240tick)
scoreboard players set @s cd_beast_wolf 240

# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 狼を召喚 (NoAI=1 で wolf_tick による手動制御、Invulnerable で永続)
# wolf_tick がブロック衝突判定 + 1ブロック階段登りを handle
summon wolf ~ ~ ~ {Tags:["beast_wolf","new_wolf"],NoAI:1b,Invulnerable:1b,CollarColor:7b,CustomName:'{"text":"狼","color":"gray","italic":false}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:0b}

# IDと攻撃タイマー設定 (寿命管理は廃止)
execute as @e[tag=new_wolf,limit=1] run scoreboard players operation @s player_id = #TEMP player_id
execute as @e[tag=new_wolf,limit=1] run scoreboard players set @s wolf_attack_timer 0

# プレイヤーの向きと同じ向きで召喚 (パスファインディングはしてくれるので向きは初期だけ整える)
execute store result entity @e[tag=new_wolf,limit=1] Rotation[0] float 1 run data get entity @s Rotation[0] 1

tag @e[tag=new_wolf] remove new_wolf

# 演出 (短い1音のみ)
playsound minecraft:entity.wolf.bark master @a ~ ~ ~ 1.2 1.2
particle minecraft:cloud ~ ~0.5 ~ 0.3 0.2 0.3 0.05 8 force

tellraw @s [{"text":"[狼] ","color":"gray","bold":true},{"text":"駆け出せ","color":"yellow"}]
